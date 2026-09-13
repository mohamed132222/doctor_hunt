import os
from PIL import Image

ATT = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments'

def analyze(name):
    p = os.path.join(ATT, name)
    im = Image.open(p).convert('RGBA')
    w, h = im.size
    a = im.getchannel('A')
    print('====', name, im.size)
    # alpha stats
    opaque = 0
    transparent = 0
    max_alpha = 0
    max_xy = (0,0)
    for y in range(0, h, 2):
        for x in range(0, w, 2):
            v = a.getpixel((x, y))
            if v > 200: opaque += 1
            if v < 20: transparent += 1
            if v > max_alpha:
                max_alpha = v; max_xy = (x, y)
    total = ((w+1)//2) * ((h+1)//2)
    print(f'opaque {opaque} ({100*opaque/total:.0f}%), transparent {transparent} ({100*transparent/total:.0f}%), max_alpha {max_alpha}')
    # corners
    print('corners', im.getpixel((0,0)), im.getpixel((w-1,0)), im.getpixel((0,h-1)), im.getpixel((w-1,h-1)))
    # center
    print('center', im.getpixel((w//2, h//2)))
    # max alpha pixel color
    print('max alpha pixel', max_xy, im.getpixel(max_xy))

analyze('20260912-233130-0f388028-554-Ellipse 142.png')
analyze('20260912-233131-2abf4e3e-83e-Ellipse 143.png')
