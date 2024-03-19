import cv2
import pandas as pd
import requests
from ultralytics import YOLO
from tracker import *
import cvzone

API_URL = 'http://localhost:5000/update_counts'
model = YOLO('backend/ObjectCounting/best.pt')

# Function to send counts to the Flask API
def send_counts_to_api(count_data):
    requests.post(API_URL, json=count_data)

def RGB(event, x, y, flags, param):
    if event == cv2.EVENT_MOUSEMOVE:
        colorsBGR = [x, y]
        print(colorsBGR)


cv2.namedWindow('CeraFlaw')
# cv2.setMouseCallback('RGB', RGB)
cap = cv2.VideoCapture(0)

my_file = open("backend/ObjectCounting/defect.txt", "r")
data = my_file.read()
class_list = data.split("\n")

count = 0
cx1 = 510

tracker1 = Tracker()
tracker2 = Tracker()
tracker3 = Tracker()

counter1 = []
counter2 = []
counter3 = []
offset = 15

while True:
    ret, frame = cap.read()
    if not ret:
        break

    count += 1
    if count % 3 != 0:
        continue

    frame = cv2.resize(frame, (1020, 500))

    results = model.predict(frame)
    a = results[0].boxes.data
    px = pd.DataFrame(a).astype("float")

    list1 = []
    edge_chipping_broken_corner = []
    list2 = []
    surface_defect = []
    list3 = []
    line_crack = []

    for index, row in px.iterrows():

        x1 = int(row[0])
        y1 = int(row[1])
        x2 = int(row[2])
        y2 = int(row[3])
        d = int(row[5])
        c = class_list[d]

        if 'edge-chipping/broken-corner' in c:
            list1.append([x1, y1, x2, y2])
            edge_chipping_broken_corner.append(c)
        elif 'surface-defects' in c:
            list2.append([x1, y1, x2, y2])
            surface_defect.append(c)
        elif 'line/crack' in c:
            list3.append([x1, y1, x2, y2])
            line_crack.append(c)

    bbox1_idx = tracker1.update(list1)
    bbox2_idx = tracker2.update(list2)
    bbox3_idx = tracker3.update(list3)

    # for edge-chipping/broken-corner
    for bbox1 in bbox1_idx:
        for i in edge_chipping_broken_corner:
            x3, y3, x4, y4, id1 = bbox1

            # calculating center points
            cxe = int(x3 + x4) // 2
            cye = int(y3 + y4) // 2

            # delete
            cv2.rectangle(frame, (x3, y3), (x4, y4), (255, 0, 0), 1)

            if (cx1 + offset) > cxe > (cx1 - offset):
                cv2.circle(frame, (cxe, cye), 4, (0, 255, 0), -1)
                cv2.rectangle(frame, (x3, y3), (x4, y4), (255, 0, 0), 1)
                cvzone.putTextRect(frame, f'{id1}', (x3, y3), 1, 1)
                if counter1.count(id1) == 0:
                    counter1.append(id1)

    # for surface-defects
    for bbox2 in bbox2_idx:
        for h in surface_defect:
            x5, y5, x6, y6, id2 = bbox2

            # calculating center points
            cxs = int(x5 + x6) // 2
            cys = int(y5 + y6) // 2

            # delete
            cv2.rectangle(frame, (x5, y5), (x6, y6), (0, 255, 0), 1)

            if (cx1 + offset) > cxs > (cx1 - offset):
                cv2.circle(frame, (cxs, cys), 4, (0, 255, 0), -1)
                cv2.rectangle(frame, (x5, y5), (x6, y6), (0, 255, 0), 1)
                cvzone.putTextRect(frame, f'{id2}', (x5, y5), 1, 1)
                if counter2.count(id2) == 0:
                    counter2.append(id2)

    # for line/crack
    for bbox3 in bbox3_idx:
        for j in line_crack:
            x7, x8, y7, y8, id3 = bbox3
            cxl = int(x7 + x8) // 2
            cyl = int(y7 + y8) // 2
            if (cx1 + offset) > cxl > (cx1 - offset):
                cv2.circle(frame, (cxl, cyl), 4, (0, 255, 0), -1)
                cv2.rectangle(frame, (x7, y7), (x8, y8), (0, 0, 255), 1)
                cvzone.putTextRect(frame, f'{id3}', (x7, y7), 1, 1)
                if counter3.count(id3) == 0:
                    counter3.append(id3)

    cv2.line(frame, (cx1, 0), (cx1, 500), (0, 0, 255), 2)

    edge_chipping_broken_corner_count = len(counter1)
    surface_defect_count = len(counter2)
    line_crack_count = len(counter3)

    #commneting this down so the terminal is clear
    #print(edge_chipping_broken_corner_count)
    #print(surface_defect_count)
    #print(line_crack_count)
    
    #setting the counts to a list
    count_data = {
        'edge_chipping_broken_corner_count': edge_chipping_broken_corner_count,
        'surface_defect_count': surface_defect_count,
        'line_crack_count': line_crack_count
    }

    # Send counts to the Flask API
    send_counts_to_api(count_data)

    #Commenting this down so that the screen does not show the result
    #cvzone.putTextRect(frame, f'edge-chipping/broken-corner:-{edge_chipping_broken_corner_count}', (19, 30), 2, 1)
    #cvzone.putTextRect(frame, f'surface-defect:-{surface_defect_count}', (19, 70), 2, 1)
    #cvzone.putTextRect(frame, f'line/crack:-{line_crack_count}', (19, 115), 2, 1)

    cv2.imshow("Ceraflaw", frame)
    if cv2.waitKey(1) & 0xFF == 27:
        break



cap.release()
cv2.destroyAllWindows()
