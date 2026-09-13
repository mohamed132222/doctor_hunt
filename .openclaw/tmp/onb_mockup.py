import os
from PIL import Image, ImageDraw, ImageFont

ROOT = r'E:\flutter route\Andriod Studio\doctor_hunt'
IMG = os.path.join(ROOT, 'assets', 'images')
FONT = os.path.join(ROOT, 'assets', 'fonts', 'Rubik.ttf')

W, H = 375, 812
canvas = Image.new('RGBA', (W, H), (255, 255, 255, 255))

# shape top-left (scaled to 240 wide, offset -60,-40)
shape = Image.open(os.path.join(IMG, 'onboarding_shape.png')).convert('RGBA')
sw = 240
sh = int(shape.height * sw / shape.width)
shape = shape.resize((sw, sh), Image.LANCZOS)
canvas.alpha_composite(shape, (-60, -40))

# glow bottom-right (300 wide, offset -60,-60)
glow = Image.open(os.path.join(IMG, 'onboarding_glow.png')).convert('RGBA')
gw = 300
gh = int(glow.height * gw / glow.width)
glow = glow.resize((gw, gh), Image.LANCZOS)
canvas.alpha_composite(glow, (W - gw + 60, H - gh + 60))

# illustration 336x336 at (20, 91)
ill = Image.open(os.path.join(IMG, 'onboarding_1.png')).convert('RGBA')
canvas.alpha_composite(ill, (20, 91))

def rubik(size, weight):
    f = ImageFont.truetype(FONT, size)
    f.set_variation_by_axes([weight])
    return f

def draw_center(text, font, y, fill, tracking=0.0, line_h=None):
    d = ImageDraw.Draw(canvas)
    # simple single-line centered (title/subtitle single line for mock)
    bbox = d.textbbox((0, 0), text, font=font)
    tw = bbox[2] - bbox[0]
    d.text(((W - tw) / 2, y), text, font=font, fill=fill)

# title
draw_center('Find Trusted Doctors', rubik(28, 500), 455, (26, 26, 26))
# subtitle (two lines)
d = ImageDraw.Draw(canvas)
sub_f = rubik(14, 400)
lines = ['Contrary to popular belief, Lorem Ipsum is not',
         'simply random text. It has roots in a piece of it',
         'over 2000 years old.']
sy = 500
for ln in lines:
    bbox = d.textbbox((0, 0), ln, font=sub_f)
    d.text(((W - (bbox[2]-bbox[0])) / 2, sy), ln, font=sub_f, fill=(107, 114, 128))
    sy += 23

# button 295x54 at (40, 679), radius 10
btn = Image.new('RGBA', (295, 54), (0, 0, 0, 0))
bd = ImageDraw.Draw(btn)
bd.rounded_rectangle((0, 0, 294, 53), radius=10, fill=(16, 185, 129))
bf = rubik(18, 500)
bb = bd.textbbox((0, 0), 'Next', font=bf)
bd.text(((295-(bb[2]-bb[0]))/2, (54-(bb[3]-bb[1]))/2 - 3), 'Next', font=bf, fill=(255, 255, 255))
canvas.alpha_composite(btn, (40, 679))

# skip
sk = rubik(14, 400)
bbox = d.textbbox((0, 0), 'Skip', font=sk)
d.text(((W - (bbox[2]-bbox[0])) / 2, 748), 'Skip', font=sk, fill=(107, 114, 128))

canvas.convert('RGB').save(os.path.join(ROOT, '.openclaw', 'tmp', 'onboarding_mockup.png'))
print('saved mockup', canvas.size)
