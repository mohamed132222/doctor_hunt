import os
from PIL import Image

p = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments\20260913-012219-44954395-f96-02_Onboarding screen-01.png'
im = Image.open(p).convert('RGB')
W, H = im.size
px = im.load()

def near_white(c):
    r, g, b = c
    return r > 246 and g > 246 and b > 246

# vertical profile of non-white pixels
print('y : nonwhite (every 6px)')
prev = 0
for y in range(0, H, 6):
    cnt = sum(1 for x in range(0, W, 3) if not near_white(px[x, y]))
    print(f'{y:4d} {cnt:4d}')
