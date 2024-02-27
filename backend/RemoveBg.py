from rembg import remove
from PIL import Image
import os

folder_path = "TileFrames"
output_folder = "NoBgTileFrames"

# Get a list of all files in the folder
file_list = os.listdir(folder_path)

# Filter only image files (you can customize the extension as needed)
image_files = [file for file in file_list if file.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp'))]

for image_file in image_files:
    # Construct the full path to the image file
    image_path = os.path.join(folder_path, image_file)

    img = Image.open(image_path)
    #using remove method
    output_image = remove(img)    

    # Construct the output path for the processed image
    output_path = os.path.join(output_folder, image_file.lower())  

    # Convert the image to 'RGB' mode before saving as JPEG
    output_image = output_image.convert('RGB')

    # Save the processed image to the output folder
    output_image.save(output_path)

    img.close()
