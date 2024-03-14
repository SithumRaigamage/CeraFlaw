from ultralytics import YOLO
import os

# Load a model
model = YOLO("best.pt")

# Run inference on the source

# Predict one image
model.predict(source="data/MacTiles/DSC_0589.JPG")

# Predict, display and save one video
model(source="videos/tile.mp4", show=True, save=True, conf=0.35)

# Predict, display and save live video
model(source=0, show=True, save=True, conf=0.35)

# Predict multiple files
# Set the input and output folders
input_folder = 'output_images'

# loop through all files in input folder
for filename in os.listdir(input_folder):
    if filename.endswith('.JPG') or filename.endswith('.png'):
        # define input and output file paths
        input_path = os.path.join(input_folder, filename)

        #model.predict(source="output_images/" + filename)
        model.predict(source=input_folder + "/" + filename)

