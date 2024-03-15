from ultralytics import YOLO
import os

# Load a model
model = YOLO("backend/best.pt")

# model.predict(source="data/MacTiles/DSC_0589.JPG")

# Set the input and output folders
input_folder = 'backend/output_images'

# loop through all files in input folder
for filename in os.listdir(input_folder):
    if filename.endswith('.JPG') or filename.endswith('.png'):
        # define input and output file paths
        input_path = os.path.join(input_folder, filename)

        #model.predict(source="output_images/" + filename)
        model.predict(source=input_folder + "/" + filename)

