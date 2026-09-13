import os
from PIL import Image

p = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments\20260913-012219-44954395-f96-02_Onboarding screen-01.png'
im = Image.open(p).convert('RGB')
W, H = im.size
print('size', im.size)
px = im.load()

def is_green(c):
    r, g, b = c
    return g > 130 and r < 120 and b < 170 and g - r > 40

def is_dark(c):
    r, g, b = c
    return r < 110 and g < 110 and b < 110

def is_gray_text(c):
    r, g, b = c
    return 90 < r < 170 and 90 < g < 170 and 90 < b < 170

# --- Button: scan green region in lower half ---
green_rows = []
for y in range(H // 2, H):
    cnt = sum(1 for x in range(0, W, 2) if is_green(px[x, y]))
    if cnt > 20:
        green_rows.append((y, cnt))
if green_rows:
    ys = [y for y, _ in green_rows]
    print('green band y:', min(ys), '->', max(ys))
    ymid = (min(ys) + max(ys)) // 2
    xs = [x for x in range(W) if is_green(px[x, ymid])]
    print('  at ymid', ymid, 'x:', min(xs), '->', max(xs), 'width', max(xs) - min(xs) + 1)

# --- Text bands in the middle (dark pixels) ---
print('--- dark text bands (y ranges) ---')
band = None
for y in range(300, 700):
    cnt = sum(1 for x in range(0, W) if is_dark(px[x, y]))
    if cnt > 8:
        if band is None:
            band = [y, y]
        else:
            band[1] = y
    else:
        if band is not None:
            print('  dark band', band, 'height', band[1] - band[0] + 1)
            band = None
if band:
    print('  dark band', band)

# --- Gray subtitle bands ---
print('--- gray text bands ---')
band = None
for y in range(400, 700):
    cnt = sum(1 for x in range(0, W) if is_gray_text(px[x, y]))
    if cnt > 15:
        if band is None:
            band = [y, y]
        else:
            band[1] = y
    else:
        if band is not None:
            print('  gray band', band, 'height', band[1] - band[0] + 1)
            band = None
if band:
    print('  gray band', band)

# --- Circle: find leftmost/rightmost/top/bottom of photo region ---
print('--- circle bounds (scan for non-white, non-green content in upper area) ---')
def is_photo(c):
    r, g, b = c
    # not near-white and not the flat green shape
    if r > 235 and g > 235 and b > 235:
        return False
    return True
top = None; bottom = None; left = W; right = 0
for y in range(50, 520):
    xs = [x for x in range(W) if is_photo(px[x, y])]
    if len(xs) > 30:
        if top is None:
            top = y
        bottom = y
for y in [200, 250, 300]:
    xs = [x for x in range(W) if is_photo(px[x, y])]
    if xs:
        left = min(left, min(xs)); right = max(right, max(xs))
print('  approx circle top', top, 'bottom', bottom, 'left', left, 'right', right)
