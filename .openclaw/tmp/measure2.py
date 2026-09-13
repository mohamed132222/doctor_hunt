import os
from PIL import Image

p = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments\20260913-012219-44954395-f96-02_Onboarding screen-01.png'
im = Image.open(p).convert('RGB')
W, H = im.size
px = im.load()

def near_white(c):
    r, g, b = c
    return r > 246 and g > 246 and b > 246

# circle top/bottom via column x=350 (right side, away from top-left green shape)
col = 350
ys = [y for y in range(H) if not near_white(px[col, y])]
print('col350 non-white y range:', min(ys), max(ys))
# circle left/right at its vertical center
cy = 259
xs = [x for x in range(W) if not near_white(px[x, cy])]
print('row259 non-white x range:', min(xs), max(xs), 'width', max(xs)-min(xs)+1)

# text bands: dark ink (title) and gray ink (subtitle/skip), excluding glow
def ink(c):
    r, g, b = c
    return max(r, g, b) < 180 and abs(r-g) < 40 and abs(g-b) < 40

print('--- ink bands 430..812 ---')
band = None
for y in range(430, H):
    cnt = sum(1 for x in range(0, W) if ink(px[x, y]))
    if cnt > 6:
        if band is None:
            band = [y, y, cnt]
        else:
            band[1] = y
            band[2] = max(band[2], cnt)
    else:
        if band is not None and band[1] - band[0] >= 3:
            print('  band', band[0], '->', band[1], 'h', band[1]-band[0]+1, 'maxcnt', band[2])
        band = None
if band:
    print('  band', band[0], '->', band[1], 'h', band[1]-band[0]+1, 'maxcnt', band[2])
