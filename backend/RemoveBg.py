from rembg import remove
from PIL import Image
import os

# Set the input and output folders
input_folder = 'input_images'
output_folder = 'output_images'

# loop through all files in input folder
for filename in os.listdir(input_folder):
    if filename.endswith('.JPG') or filename.endswith('.png'):
        # define input and output file paths
        input_path = os.path.join(input_folder, filename)
        output_path = os.path.join(output_folder, filename.split('.')[0] + '.png')

        # load the input image
        input_image = Image.open(input_path)

        # remove the background
        output_image = remove(input_image)

        # save the output into PNG
        output_image.save(output_path)
