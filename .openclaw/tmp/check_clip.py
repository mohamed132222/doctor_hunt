import os
from PIL import Image

OUT = r'E:\flutter route\Andriod Studio\doctor_hunt\assets\splash'

# Check the combined splash.png and the wordmark region for bottom clipping.
sp = Image.open(os.path.join(OUT, 'splash.png')).convert('RGBA')
w, h = sp.size
print('splash.png', sp.size)
# bottom 3 rows: any non-transparent pixels touching bottom edge?
for name, img in [('splash.png', sp)]:
    w, h = img.size
    a = img.getchannel('A')
    bottom_rows = [a.getpixel((x, h-1)) for x in range(0, w, 2)]
    print(name, 'bottom-edge max alpha', max(bottom_rows))
    # find lowest y with content
    lowest = 0
    for y in range(h-1, -1, -1):
        if any(a.getpixel((x, y)) > 10 for x in range(0, w, 2)):
            lowest = y
            break
    print(name, 'lowest content y =', lowest, 'of', h, '=> padding below =', h-1-lowest)
