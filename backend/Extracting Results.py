from ultralytics import YOLO

# Load a model
model = YOLO('best.pt')  # pretrained YOLOv8n model

# Run batched inference on an images
results = model.predict('DSC_0648.JPG')

# Extract bounding boxes, classes, names, and confidences
boxes = results[0].boxes.xyxy.tolist()
classes = results[0].boxes.cls.tolist()
confidences = results[0].boxes.conf.tolist()
names = model.model.names

# Iterate through the results
for box, cls, conf in zip(boxes, classes, confidences):
    x1, y1, x2, y2 = box
    confidence = conf
    print(confidence)

    # add a count to count number of defects

    detected_class = cls
    print(detected_class)
    name = names[int(cls)]
    print(name)