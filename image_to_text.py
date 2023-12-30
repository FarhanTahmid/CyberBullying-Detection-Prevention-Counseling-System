import cv2
import pytesseract
from PIL import Image

def detectLanguage(image):
        image=Image.open(image)
        pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
        # Perform OCR to extract text from the image
        # Set the language to Bangla (Bengali)
        custom_config_bangla = r'--oem 3 --psm 6 -l ben'

        # Set the language to English
        custom_config_english = r'--oem 3 --psm 6 -l eng'

        #to detect Bangla only
        text = pytesseract.image_to_string(image,config=custom_config_bangla)
        
        # try:
        #     text = pytesseract.image_to_string(image,config=custom_config_english)
        # except:
        #     text = pytesseract.image_to_string(image, config=custom_config_bangla)
        return text
    
detectLanguage('picture_text.PNG')
