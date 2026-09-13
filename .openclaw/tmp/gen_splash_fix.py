import os
from PIL import Image, ImageDraw, ImageFont

ATT = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments'
OUT = r'E:\flutter route\Andriod Studio\doctor_hunt\assets\splash'
FONT = r'E:\flutter route\Andriod Studio\doctor_hunt\assets\fonts\Rubik.ttf'

ell_teal = Image.open(os.path.join(ATT, '20260912-233130-0f388028-554-Ellipse 142.png')).convert('RGBA')
ell_green = Image.open(os.path.join(ATT, '20260912-233131-2abf4e3e-83e-Ellipse 143.png')).convert('RGBA')
vec = Image.open(os.path.join(ATT, '20260912-205954-c07ec83c-f3a-splash_vector.png')).convert('RGBA')

# ── background.png : white + teal (top-left) + green (bottom-right) ─────────
BG = (1080, 2340)
SCALE = 1080 / 375.0
bg = Image.new('RGBA', BG, (255, 255, 255, 255))
teal = ell_teal.resize((int(ell_teal.width*SCALE), int(ell_teal.height*SCALE)), Image.LANCZOS)
bg.alpha_composite(teal, (-120, -80))
green = ell_green.resize((int(ell_green.width*SCALE), int(ell_green.height*SCALE)), Image.LANCZOS)
bg.alpha_composite(green, (BG[0]-green.size[0]+60, BG[1]-green.size[1]+60))
bg.convert('RGB').save(os.path.join(OUT, 'background.png'))
print('background.png', BG)

# ── wordmark: "Doctor Hunt" Rubik Bold 700, #222222, letter-spacing -0.3px ──
FONT_PX = 100
TRACKING = -0.3 * 4
TEXT_COLOR = (34, 34, 34, 255)
PAD_X = 8
PAD_TOP = 8
PAD_BOTTOM = 12  # extra breathing room below the baseline

font = ImageFont.truetype(FONT, FONT_PX)
font.set_variation_by_axes([700])
ascent, descent = font.getmetrics()
print('font metrics: ascent', ascent, 'descent', descent, 'line height', ascent+descent)

text = 'Doctor Hunt'

def render_tracked(text, font, tracking, color):
    tmp = Image.new('RGBA', (10, 10))
    d = ImageDraw.Draw(tmp)
    widths = []
    for ch in text:
        bbox = d.textbbox((0, 0), ch, font=font)
        widths.append(bbox[2] - bbox[0])
    total_w = int(sum(widths) + tracking * (len(text) - 1)) + PAD_X * 2
    # Full vertical extent = ascent + descent + padding, so nothing clips.
    total_h = ascent + descent + PAD_TOP + PAD_BOTTOM
    canvas = Image.new('RGBA', (total_w, total_h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(canvas)
    # Anchor at 'la' (left-ascender): y = PAD_TOP puts the ascent line there,
    # so the ink fits within [PAD_TOP, PAD_TOP+ascent+descent].
    x = PAD_X
    for ch, w in zip(text, widths):
        draw.text((x, PAD_TOP), ch, font=font, fill=color)
        x += w + tracking
    return canvas

wordmark = render_tracked(text, font, TRACKING, TEXT_COLOR)
print('wordmark size', wordmark.size)

# ── splash.png : cross + wordmark stacked ───────────────────────────────────
CROSS = 296
gap = 96
wm = wordmark
canvas_w = max(CROSS, wm.width)
canvas_h = CROSS + gap + wm.height
comp = Image.new('RGBA', (canvas_w, canvas_h), (0, 0, 0, 0))
cross = vec.resize((CROSS, CROSS), Image.LANCZOS)
comp.alpha_composite(cross, ((canvas_w - CROSS)//2, 0))
comp.alpha_composite(wm, ((canvas_w - wm.width)//2, CROSS + gap))
comp.save(os.path.join(OUT, 'splash.png'))
print('splash.png', comp.size)

# ── branding_android12.png : 800x320 "Doctor Hunt" centered ─────────────────
BRAND = (800, 320)
fit = min((BRAND[0]*0.7)/wm.width, (BRAND[1]*0.5)/wm.height)
bw2, bh2 = int(wm.width*fit), int(wm.height*fit)
wm2 = wm.resize((bw2, bh2), Image.LANCZOS)
brand = Image.new('RGBA', BRAND, (0, 0, 0, 0))
brand.alpha_composite(wm2, ((BRAND[0]-bw2)//2, (BRAND[1]-bh2)//2))
brand.save(os.path.join(OUT, 'branding_android12.png'))
print('branding_android12.png', BRAND, 'wordmark', (bw2, bh2))

print('DONE')
