from PIL import Image
import numpy as np

def convert_to_png_with_transparent_background(input_image_path, output_image_path):
    # Open the image and convert it to RGBA format
    image = Image.open(input_image_path).convert("RGBA")
    
    # Convert the image to a numpy array
    image_array = np.array(image)
    
    # Extract the alpha channel
    alpha = image_array[:, :, 3]
    
    # Create a new array with the alpha channel set to 0 (i.e. transparent)
    transparent_array = np.zeros_like(image_array)
    transparent_array[:, :, 3] = alpha
    
    # Convert the transparent array back to an image
    transparent_image = Image.fromarray(transparent_array)
    
    # Save the image as a PNG file
    transparent_image.save(output_image_path, format="PNG")

# Example usage
convert_to_png_with_transparent_background("input.jpg", "output.png")