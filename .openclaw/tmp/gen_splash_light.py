import os
from PIL import Image

ATT = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments'
OUT = r'E:\flutter route\Andriod Studio\doctor_hunt\assets\splash'
os.makedirs(OUT, exist_ok=True)

bg = Image.open(os.path.join(ATT, '20260912-205954-6ed5511f-8d3-bg.png')).convert('RGBA')
vec = Image.open(os.path.join(ATT, '20260912-205954-c07ec83c-f3a-splash_vector.png')).convert('RGBA')
txt = Image.open(os.path.join(ATT, '20260912-205954-7a947d0a-141-splash_text.png')).convert('RGBA')

# Design proportions (from reference, 375px-wide canvas):
#   cross ~74px, gap ~24px, wordmark ~158px wide
CROSS = 300              # target cross width in combined image (px)
RATIO_TEXT_TO_CROSS = 158 / 74   # wordmark width / cross width
RATIO_GAP_TO_CROSS = 24 / 74     # gap / cross width

text_w = int(CROSS * RATIO_TEXT_TO_CROSS)
text_h = int(text_w * txt.height / txt.width)
gap = int(CROSS * RATIO_GAP_TO_CROSS)

# ── 1) background.png : WHITE base + glows (1080x2340) ─────────────────────
BG = (1080, 2340)
white = Image.new('RGBA', BG, (255, 255, 255, 255))
bg_scaled = bg.resize(BG, Image.LANCZOS)
white.alpha_composite(bg_scaled)
white.convert('RGB').save(os.path.join(OUT, 'background.png'))
print('background.png (white + glows)', BG)

# ── 2) splash.png : combined cross + dark text, transparent ────────────────
canvas_w = max(CROSS, text_w)
canvas_h = CROSS + gap + text_h
comp = Image.new('RGBA', (canvas_w, canvas_h), (0, 0, 0, 0))
cross = vec.resize((CROSS, CROSS), Image.LANCZOS)
comp.alpha_composite(cross, ((canvas_w - CROSS) // 2, 0))
wm = txt.resize((text_w, text_h), Image.LANCZOS)
comp.alpha_composite(wm, ((canvas_w - text_w) // 2, CROSS + gap))
comp.save(os.path.join(OUT, 'splash.png'))
print('splash.png (cross + dark text)', comp.size)

# ── 3) logo.png : green cross alone (512) ──────────────────────────────────
L = 512
logo = Image.new('RGBA', (L, L), (0, 0, 0, 0))
logo.alpha_composite(vec.resize((L, L), Image.LANCZOS))
logo.save(os.path.join(OUT, 'logo.png'))
print('logo.png', (L, L))

# ── 4) logo_android12.png : 1152x1152, cross fit within 768px circle ───────
A12 = 1152
fit = 700
a12 = Image.new('RGBA', (A12, A12), (0, 0, 0, 0))
a12.alpha_composite(vec.resize((fit, fit), Image.LANCZOS), ((A12 - fit) // 2, (A12 - fit) // 2))
a12.save(os.path.join(OUT, 'logo_android12.png'))
print('logo_android12.png', (A12, A12))

# ── 5) branding_android12.png : 800x320 dark text centered ────────────────
BRAND = (800, 320)
bw = int(BRAND[0] * 0.7)
bh = int(bw * txt.height / txt.width)
brand = Image.new('RGBA', BRAND, (0, 0, 0, 0))
brand.alpha_composite(txt.resize((bw, bh), Image.LANCZOS), ((BRAND[0] - bw) // 2, (BRAND[1] - bh) // 2))
brand.save(os.path.join(OUT, 'branding_android12.png'))
print('branding_android12.png (dark text)', BRAND, 'wordmark', (bw, bh))

print('DONE')
