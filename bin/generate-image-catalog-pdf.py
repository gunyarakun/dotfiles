#!/usr/bin/env python
# pip install fpdf2 Pillow
import glob
from fpdf import FPDF
from PIL import Image, ExifTags

img_types = ('*.jpeg', '*.jpg', '*.JPG', '*.JPEG', '.png', '.PNG', '.gif', '.GIF')
paths = []
for img_type in img_types:
    paths.extend(glob.glob(f"**/{img_type}", recursive=True))

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

IMAGES_IN_PAGE = 3 * 5

class PDF(FPDF):
    def image_table(self, paths):
        for i, path in enumerate(paths):
            x_index = i % 3
            y_index = i % 5
            x = x_index * (pdf.epw / 3)
            y = y_index * (pdf.eph / 5) + 3

            im = Image.open(path)
            exif = im._getexif()
            if exif is not None:
                if exif['Orientation'] == 3:
                    im.rotate(180, expand=True)
                elif exif['Orientation'] == 6:
                    im.rotate(270, expand=True)
                elif exif['Orientation'] == 8:
                    im.rotate(90, expand=True)

            im.thumbnail(size=(140, 140))
            self.image(im, x, y)
            self.text(x, y, path)

            if x_index == 2:
                self.ln()
        self.ln()


pdf = PDF()
pdf.set_font("helvetica", size=6)

for chunk_paths in chunks(sorted(paths), IMAGES_IN_PAGE):
    pdf.add_page()
    pdf.image_table(chunk_paths)
pdf.output('image-catalog.pdf')

