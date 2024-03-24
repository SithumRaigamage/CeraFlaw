import cv2
import pandas as pd
import requests
from ultralytics import YOLO
from tracker import *
import cvzone
import threading


class ObjectCounting:
    def __init__(self, model_path, api_url, class_file_path):
        self.model = YOLO(model_path)
        self.api_url = api_url
        self.class_list = self.load_classes(class_file_path)
        self.tracker1 = Tracker()
        self.tracker2 = Tracker()
        self.tracker3 = Tracker()
        self.counter1 = []
        self.counter2 = []
        self.counter3 = []
        self.accumulated_counts = 0
        self.offset = 15
        self.cx1 = 512

    def load_classes(self, class_file_path):
        with open(class_file_path, "r") as file:
            return file.read().split("\n")

    def send_counts_to_api(self, count_data):
        threading.Thread(target=requests.post, args=(self.api_url,), kwargs={'json': count_data}).start()

    def process_frame(self, frame):
        frame = cv2.resize(frame, (1024, 768))
        results = self.model.predict(frame)
        boxes = results[0].boxes.data
        df = pd.DataFrame(boxes).astype("float")

        list1 = []
        edge_chipping = []
        list2 = []
        surface_defect = []
        list3 = []
        line_crack = []

        for index, row in df.iterrows():
            x1, y1, x2, y2, d = row[0], row[1], row[2], row[3], int(row[5])
            # can add conf using row[4]
            class_name = self.class_list[d]

            if 'edge-chipping' in class_name:
                list1.append([x1, y1, x2, y2])
                edge_chipping.append(class_name)

            elif 'surface-defect' in class_name:
                list2.append([x1, y1, x2, y2])
                surface_defect.append(class_name)

            elif 'line/crack' in class_name:
                list3.append([x1, y1, x2, y2])
                line_crack.append(class_name)

        bbox1_idx = self.tracker1.update(list1)
        bbox2_idx = self.tracker2.update(list2)
        bbox3_idx = self.tracker3.update(list3)

        # for edge-chipping/broken-corner
        for bbox1 in bbox1_idx:
            for i in edge_chipping:
                x3, y3, x4, y4, id1 = bbox1

                # calculating center points
                cxe = int(x3 + x4) // 2
                cye = int(y3 + y4) // 2

                # delete
                cv2.rectangle(frame, (int(x3), int(y3)), (int(x4), int(y4)), (255, 0, 0), 2)

                cv2.putText(frame, f"edge chipping", (int(x3), int(y4)),
                            cv2.FONT_HERSHEY_SIMPLEX,
                            0.5, (0, 0, 0), 1, cv2.LINE_AA)

                if (self.cx1 + self.offset) > cxe > (self.cx1 - self.offset):
                    cv2.circle(frame, (cxe, cye), 4, (0, 255, 0), -1)
                    # cv2.rectangle(frame, (x3, y3), (x4, y4), (255, 0, 0), 2)
                    # cvzone.putTextRect(frame, f'{id1}', (x3, y3), 1, 1)

                    if self.counter1.count(id1) == 0:
                        self.counter1.append(id1)

            # for surface-defects
            for bbox2 in bbox2_idx:
                for h in surface_defect:
                    x5, y5, x6, y6, id2 = bbox2

                    # calculating center points
                    cxs = int(x5 + x6) // 2
                    cys = int(y5 + y6) // 2

                    # delete
                    cv2.rectangle(frame, (int(x5), int(y5)), (int(x6), int(y6)), (0, 255, 0), 2)

                    cv2.putText(frame, f"surface detect", (int(x5), int(y6)),
                                cv2.FONT_HERSHEY_SIMPLEX,
                                0.5, (0, 0, 0), 1, cv2.LINE_AA)

                    if (self.cx1 + self.offset) > cxs > (self.cx1 - self.offset):
                        cv2.circle(frame, (cxs, cys), 4, (0, 255, 0), -1)
                        # cv2.rectangle(frame, (x5, y5), (x6, y6), (0, 255, 0), 2)
                        # cvzone.putTextRect(frame, f'{id2}', (x5, y5), 1, 1)

                        if self.counter2.count(id2) == 0:
                            self.counter2.append(id2)

            # for line/crack
            for bbox3 in bbox3_idx:
                for j in line_crack:
                    x7, x8, y7, y8, id3 = bbox3
                    cxl = int(x7 + x8) // 2
                    cyl = int(y7 + y8) // 2

                    # delete
                    cv2.rectangle(frame, (int(x7), int(y7)), (int(x8), int(y8)), (0, 0, 255), 2)

                    cv2.putText(frame, f"line/crack", (int(x7), int(y8)),
                                cv2.FONT_HERSHEY_SIMPLEX,
                                0.5, (0, 0, 0), 1, cv2.LINE_AA)

                    if (self.cx1 + self.offset) > cxl > (self.cx1 - self.offset):
                        cv2.circle(frame, (cxl, cyl), 4, (0, 255, 0), -1)
                        # cv2.rectangle(frame, (x7, y7), (x8, y8), (0, 0, 255), 2)
                        # cvzone.putTextRect(frame, f'{id3}', (x7, y7), 1, 1)

                        if self.counter3.count(id3) == 0:
                            self.counter3.append(id3)

        cv2.line(frame, (self.cx1, 0), (self.cx1, 768), (0, 0, 255), 2)

        edge_chipping_count = len(self.counter1)
        surface_defect_count = len(self.counter2)
        line_crack_count = len(self.counter3)

        count_data = {
            'edge_chipping_count': edge_chipping_count,
            'surface_defect_count': surface_defect_count,
            'line_crack_count': line_crack_count
        }

        if self.accumulated_counts % 100 == 0:
            self.send_counts_to_api(count_data)
            self.counter1 = []
            self.counter2 = []
            self.counter3 = []
            self.accumulated_counts = 0

        self.accumulated_counts += 1
        return frame

    def run(self):
        cap = cv2.VideoCapture(1)
        while True:
            ret, frame = cap.read()
            if not ret:
                break
            frame = self.process_frame(frame)
            cv2.imshow("Ceraflaw", frame)
            if cv2.waitKey(1) & 0xFF == 27:
                break
        cap.release()
        cv2.destroyAllWindows()

# Example usage
# object_counter = ObjectCounting('backend\ObjectCounting\sbest.pt', 'http://localhost:5000/update_counts', 'backend\ObjectCounting\defect.txt')
object_counter = ObjectCounting(r'backend/ObjectCounting/sbest.pt', r'http://localhost:5000/update_counts', r'backend/ObjectCounting/defect.txt')

object_counter.run()
