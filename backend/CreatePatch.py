import numpy as np
from PIL import Image
import os

folder_path = "NoBgTileFrames"

# Getting a list of all files in the folder
file_list = os.listdir(folder_path)

#Filtering only image files (you can customize the extension as needed)
image_files = [file for file in file_list if file.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp'))]

for image_file in image_files:
    #Constructin the full path to the image file
    image_path = os.path.join(folder_path, image_file)
    img = Image.open(image_path)   

    #Converting to NumPy array
    image_array = np.array(img)

    #2x2 for a total of 4 pieces
    num_pieces = (2, 2)

    #Calculating the size of each piece
    piece_height = image_array.shape[0] // num_pieces[0]
    piece_width = image_array.shape[1] // num_pieces[1]

    #saving all the pieces 
    save_dir = "Patches"
    if not os.path.exists(save_dir):
        os.makedirs(save_dir)

    #saving the pieces as JPG images
    piece_count = 1
    for i in range(num_pieces[0]):
        for j in range(num_pieces[1]):
            piece = image_array[i * piece_height:(i + 1) * piece_height, j * piece_width:(j + 1) * piece_width, :]

            # Convert a piece to PIL image for JPG saving
            piece_image = Image.fromarray(piece.astype(np.uint8))

            #Saving with a unique name based on piece index
            save_path = os.path.join(save_dir, f"{os.path.splitext(image_file)[0]}_patch_{piece_count}.jpg")
            piece_image.save(save_path)

            piece_count += 1

    #Handling cases where fewer pieces were extracted
    if piece_count <= np.prod(num_pieces):
        print(f"Successfully saved {piece_count - 1} pieces for {image_file} to {save_dir}.")
    else:
        print(f"Warning: Only {np.prod(num_pieces)} pieces requested, but {piece_count - 1} pieces were extracted for {image_file} based on limitations.")
