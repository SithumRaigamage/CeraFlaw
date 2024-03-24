# Import necessary libraries
import cv2
import pandas as pd
import requests
from ultralytics import YOLO
from tracker import *
import threading


class ObjectCounting:
    def __init__(self, model_path, api_url, class_file_path):
        # Initialize YOLO model with the specified model path
        self.model = YOLO(model_path)
        # Store API URL for sending count data
        self.api_url = api_url
        # Load class names from the specified file
        self.class_list = self.load_classes(class_file_path)
        # Initialize trackers for different types of defects
        self.tracker1 = Tracker()
        self.tracker2 = Tracker()
        self.tracker3 = Tracker()
        # Initialize counters for different types of defects
        self.counter1 = []
        self.counter2 = []
        self.counter3 = []
        # Define offset and center x-coordinate for line detection
        self.offset = 15
        self.cx1 = 512

    def load_classes(self, class_file_path):
        # Load class names from a file
        with open(class_file_path, "r") as file:
            return file.read().split("\n")

    def send_counts_to_api(self, count_data):
        # Send count data to the specified API URL
        # requests.post(self.api_url, json=count_data)
        threading.Thread(target=requests.post, args=(self.api_url,), kwargs={'json': count_data}).start()

    def process_frame(self, frame):
        # Process each frame for object detection and counting
        # Resize frame for processing
        frame = cv2.resize(frame, (1024, 768))
        # Perform object detection
        results = self.model.predict(frame)
        # Extract bounding boxes and class IDs
        boxes = results[0].boxes.data
        # Convert bounding boxes to a DataFrame for easier manipulation
        df = pd.DataFrame(boxes).astype("float")

        # Initialize lists for different types of defects
        list1 = []
        edge_chipping = []
        list2 = []
        surface_defect = []
        list3 = []
        line_crack = []

        # Iterate over each detected object
        for index, row in df.iterrows():
            # Extract bounding box coordinates and class ID
            x1, y1, x2, y2, d = row[0], row[1], row[2], row[3], int(row[5])
            # Get class name based on class ID
            class_name = self.class_list[d]

            # Classify objects based on class name
            if 'edge-chipping' in class_name:
                list1.append([x1, y1, x2, y2])
                edge_chipping.append(class_name)

            elif 'surface-defect' in class_name:
                list2.append([x1, y1, x2, y2])
                surface_defect.append(class_name)

            elif 'line/crack' in class_name:
                list3.append([x1, y1, x2, y2])
                line_crack.append(class_name)
        
        # Update trackers with new detections
        bbox1_idx = self.tracker1.update(list1)
        bbox2_idx = self.tracker2.update(list2)
        bbox3_idx = self.tracker3.update(list3)

        # Process each type of defect
        # For edge-chipping
        for bbox1 in bbox1_idx:
            for i in edge_chipping:
                x3, y3, x4, y4, id1 = bbox1

                # Calculate center points
                cxe = int(x3 + x4) // 2
                cye = int(y3 + y4) // 2

                # Draw bounding box and label
                cv2.rectangle(frame, (int(x3), int(y3)), (int(x4), int(y4)), (255, 0, 0), 2)
                cv2.putText(frame, f"edge chipping", (int(x3), int(y4)), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1, cv2.LINE_AA)

                # Check if the object is within the specified range
                if (self.cx1 + self.offset) > cxe > (self.cx1 - self.offset):
                    cv2.circle(frame, (cxe, cye), 4, (0, 255, 0), -1)

                    if self.counter1.count(id1) == 0:
                        self.counter1.append(id1)

            # For surface-defects
            for bbox2 in bbox2_idx:
                for h in surface_defect:
                    x5, y5, x6, y6, id2 = bbox2

                    # Calculate center points
                    cxs = int(x5 + x6) // 2
                    cys = int(y5 + y6) // 2

                    # Draw bounding box and label
                    cv2.rectangle(frame, (int(x5), int(y5)), (int(x6), int(y6)), (0, 255, 0), 2)
                    cv2.putText(frame, f"surface detect", (int(x5), int(y6)),
                                cv2.FONT_HERSHEY_SIMPLEX,
                                0.5, (0, 0, 0), 1, cv2.LINE_AA)

                    # Check if the object is within the specified range
                    if (self.cx1 + self.offset) > cxs > (self.cx1 - self.offset):
                        cv2.circle(frame, (cxs, cys), 4, (0, 255, 0), -1)

                        if self.counter2.count(id2) == 0:
                            self.counter2.append(id2)

            # For line/crack
            for bbox3 in bbox3_idx:
                for j in line_crack:
                    x7, x8, y7, y8, id3 = bbox3

                    # Calculate center points
                    cxl = int(x7 + x8) // 2
                    cyl = int(y7 + y8) // 2

                    # Draw bounding box and label
                    cv2.rectangle(frame, (int(x7), int(y7)), (int(x8), int(y8)), (0, 0, 255), 2)
                    cv2.putText(frame, f"line/crack", (int(x7), int(y8)),
                                cv2.FONT_HERSHEY_SIMPLEX,
                                0.5, (0, 0, 0), 1, cv2.LINE_AA)

                    # Check if the object is within the specified range
                    if (self.cx1 + self.offset) > cxl > (self.cx1 - self.offset):
                        cv2.circle(frame, (cxl, cyl), 4, (0, 255, 0), -1)

                        if self.counter3.count(id3) == 0:
                            self.counter3.append(id3)

        # Display center vertical line
        cv2.line(frame, (self.cx1, 0), (self.cx1, 768), (0, 0, 255), 2)

        # Calculate counts for each type of defect
        edge_chipping_count = len(self.counter1)
        surface_defect_count = len(self.counter2)
        line_crack_count = len(self.counter3)

        # Prepare count data for API
        count_data = {
            'edge_chipping_count': edge_chipping_count,
            'surface_defect_count': surface_defect_count,
            'line_crack_count': line_crack_count
        }

        # Send count data to API
        self.send_counts_to_api(count_data)

        return frame

    def run(self):
        # Main loop for capturing video frames and processing them
        cap = cv2.VideoCapture(0)
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


# Initialize the object counter with specified parameters
object_counter = ObjectCounting('backend/ObjectCounting/model_n.pt', 'http://localhost:5000/update_counts', "backend/ObjectCounting/defect.txt")

# Start the object counting process
object_counter.run()
