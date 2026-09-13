import os
from PIL import Image

p = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments\20260913-020142-a57c3ffc-242-Choose role.png'
im = Image.open(p).convert('RGB')
W, H = im.size
px = im.load()
print('size', im.size)

def near_white(c):
    return c[0] > 246 and c[1] > 246 and c[2] > 246

# horizontal non-white profile per row band
print('--- row profile (logical px) ---')
prev = -1
for y in range(0, H, 4):
    cnt = sum(1 for x in range(0, W, 3) if not near_white(px[x, y]))
    print(f'{y:4d} {cnt:4d}  ' + '#' * min(cnt // 4, 80))
