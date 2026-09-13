import os
from PIL import Image

ATT = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments'
OUT = r'E:\flutter route\Andriod Studio\doctor_hunt\assets\splash'
os.makedirs(OUT, exist_ok=True)

bg_path = os.path.join(ATT, '20260912-205954-6ed5511f-8d3-bg.png')
vec_path = os.path.join(ATT, '20260912-205954-c07ec83c-f3a-splash_vector.png')
txt_path = os.path.join(ATT, '20260912-205954-7a947d0a-141-splash_text.png')

bg = Image.open(bg_path).convert('RGBA')
vec = Image.open(vec_path).convert('RGBA')
txt = Image.open(txt_path).convert('RGBA')

# --- analyze bg alpha ---
a = bg.getchannel('A')
w, h = bg.size
max_alpha = 0
max_xy = (0, 0)
for y in range(h):
    for x in range(w):
        v = a.getpixel((x, y))
        if v > max_alpha:
            max_alpha = v
            max_xy = (x, y)
print('bg max alpha =', max_alpha, 'at', max_xy, 'color', bg.getpixel(max_xy))
print('bg size', bg.size)

# 1) background.png : flatten glows over solid black, scale to 1080x2340
TARGET = (1080, 2340)
black = Image.new('RGBA', TARGET, (0, 0, 0, 255))
bg_scaled = bg.resize(TARGET, Image.LANCZOS)
black.alpha_composite(bg_scaled)
black.convert('RGB').save(os.path.join(OUT, 'background.png'))
print('saved background.png', TARGET)

# 2) logo.png : green cross upscaled to 512x512, transparent
LOGO = 512
logo = Image.new('RGBA', (LOGO, LOGO), (0, 0, 0, 0))
vec_scaled = vec.resize((LOGO, LOGO), Image.LANCZOS)
logo.alpha_composite(vec_scaled)
logo.save(os.path.join(OUT, 'logo.png'))
print('saved logo.png', (LOGO, LOGO))

# 3) wordmark_white.png : recolor dark text to white, 4x scale
def to_white(im):
    r, g, b, a = im.split()
    white = Image.new('RGBA', im.size, (255, 255, 255, 255))
    white.putalpha(a)
    return white

tw = to_white(txt)
W4 = (txt.width * 4, txt.height * 4)
tw4 = tw.resize(W4, Image.LANCZOS)
tw4.save(os.path.join(OUT, 'wordmark_white.png'))
print('saved wordmark_white.png', W4)

# 4) splash.png : composite cross + wordmark stacked (for centered pre-12 image)
CROSS = 260
GAP = 40
word_w = txt.width * 5
word_h = txt.height * 5
canvas_w = max(CROSS, word_w) + 80
canvas_h = CROSS + GAP + word_h + 60
comp = Image.new('RGBA', (canvas_w, canvas_h), (0, 0, 0, 0))
cross_img = vec.resize((CROSS, CROSS), Image.LANCZOS)
cx = (canvas_w - CROSS) // 2
cy = 30
comp.alpha_composite(cross_img, (cx, cy))
word_img = tw.resize((word_w, word_h), Image.LANCZOS)
wx = (canvas_w - word_w) // 2
wy = cy + CROSS + GAP
comp.alpha_composite(word_img, (wx, wy))
comp.save(os.path.join(OUT, 'splash.png'))
print('saved splash.png', comp.size)

# 5) android_12 logo : 1152x1152 transparent with cross fit within 768px circle
A12 = 1152
a12 = Image.new('RGBA', (A12, A12), (0, 0, 0, 0))
fit = 700
a12vec = vec.resize((fit, fit), Image.LANCZOS)
ax = (A12 - fit) // 2
a12.alpha_composite(a12vec, (ax, ax))
a12.save(os.path.join(OUT, 'logo_android12.png'))
print('saved logo_android12.png', (A12, A12))

print('ALL DONE')
