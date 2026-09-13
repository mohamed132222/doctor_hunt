import os
from PIL import Image, ImageDraw, ImageFont

ATT = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments'
OUT = r'E:\flutter route\Andriod Studio\doctor_hunt\assets\splash'
FONT = r'E:\flutter route\Andriod Studio\doctor_hunt\assets\fonts\Rubik.ttf'
os.makedirs(OUT, exist_ok=True)

ell_teal = Image.open(os.path.join(ATT, '20260912-233130-0f388028-554-Ellipse 142.png')).convert('RGBA')
ell_green = Image.open(os.path.join(ATT, '20260912-233131-2abf4e3e-83e-Ellipse 143.png')).convert('RGBA')
vec = Image.open(os.path.join(ATT, '20260912-205954-c07ec83c-f3a-splash_vector.png')).convert('RGBA')

# ── 1) Copy ellipse assets into assets/splash (also used by Flutter splash) ──
ell_teal.save(os.path.join(OUT, 'ellipse_teal.png'))
ell_green.save(os.path.join(OUT, 'ellipse_green.png'))
print('saved ellipse_teal.png / ellipse_green.png')

# ── 2) background.png : white + teal (top-left) + green (bottom-right) ───────
BG = (1080, 2340)
SCALE = 1080 / 375.0  # design 375 -> 1080
bg = Image.new('RGBA', BG, (255, 255, 255, 255))

teal_scaled = ell_teal.resize(
    (int(ell_teal.width * SCALE), int(ell_teal.height * SCALE)), Image.LANCZOS)
bg.alpha_composite(teal_scaled, (-120, -80))  # top-left, bleed off-canvas

green_scaled = ell_green.resize(
    (int(ell_green.width * SCALE), int(ell_green.height * SCALE)), Image.LANCZOS)
gw, gh = green_scaled.size
bg.alpha_composite(green_scaled, (BG[0] - gw + 60, BG[1] - gh + 60))  # bottom-right

bg.convert('RGB').save(os.path.join(OUT, 'background.png'))
print('background.png', BG)

# ── 3) wordmark: "Doctor Hunt" Rubik Bold 700, #222222, letter-spacing -0.3px ─
# Render at 4x scale (25px * 4 = 100px) for crispness.
FONT_PX = 100
TRACKING = -0.3 * 4  # -1.2px per char at 4x
TEXT_COLOR = (34, 34, 34, 255)  # #222222

font = ImageFont.truetype(FONT, FONT_PX)
font.set_variation_by_axes([700])

text = 'Doctor Hunt'

def render_tracked(text, font, tracking, color):
    """Render text char-by-char to apply letter-spacing."""
    widths = []
    heights = []
    tmp = Image.new('RGBA', (10, 10))
    d = ImageDraw.Draw(tmp)
    for ch in text:
        bbox = d.textbbox((0, 0), ch, font=font)
        widths.append(bbox[2] - bbox[0])
        heights.append(bbox[3] - bbox[1])
    total_w = int(sum(widths) + tracking * (len(text) - 1)) + 4
    max_h = max(heights) + 4
    canvas = Image.new('RGBA', (total_w, max_h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(canvas)
    x = 2
    ascent = d.textbbox((0, 0), 'Ag', font=font)[1]  # top offset approx
    for ch, w in zip(text, widths):
        draw.text((x, 2), ch, font=font, fill=color)
        x += w + tracking
    return canvas

wordmark = render_tracked(text, font, TRACKING, TEXT_COLOR)
print('wordmark size', wordmark.size)

# ── 4) splash.png : cross + wordmark stacked (transparent) ───────────────────
CROSS = 296  # ~74px * 4
gap = 96     # ~24px * 4
wm = wordmark
canvas_w = max(CROSS, wm.width)
canvas_h = CROSS + gap + wm.height
comp = Image.new('RGBA', (canvas_w, canvas_h), (0, 0, 0, 0))
cross = vec.resize((CROSS, CROSS), Image.LANCZOS)
comp.alpha_composite(cross, ((canvas_w - CROSS) // 2, 0))
comp.alpha_composite(wm, ((canvas_w - wm.width) // 2, CROSS + gap))
comp.save(os.path.join(OUT, 'splash.png'))
print('splash.png', comp.size)

# ── 5) branding_android12.png : 800x320 "Doctor Hunt" centered ───────────────
BRAND = (800, 320)
bw = wm.width
bh = wm.height
# scale wordmark to fit 800x320 with margin
fit_scale = min((BRAND[0] * 0.7) / bw, (BRAND[1] * 0.5) / bh)
bw2 = int(bw * fit_scale)
bh2 = int(bh * fit_scale)
wm2 = wm.resize((bw2, bh2), Image.LANCZOS)
brand = Image.new('RGBA', BRAND, (0, 0, 0, 0))
brand.alpha_composite(wm2, ((BRAND[0] - bw2) // 2, (BRAND[1] - bh2) // 2))
brand.save(os.path.join(OUT, 'branding_android12.png'))
print('branding_android12.png', BRAND, 'wordmark', (bw2, bh2))

print('ALL DONE')
