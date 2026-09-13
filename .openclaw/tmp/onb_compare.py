import os
from PIL import Image, ImageDraw, ImageFont

ROOT = r'E:\flutter route\Andriod Studio\doctor_hunt'
IMG = os.path.join(ROOT, 'assets', 'images')
FONT = os.path.join(ROOT, 'assets', 'fonts', 'Rubik.ttf')
REF = os.path.join(ROOT, '.openclaw-attachments', '20260913-012219-44954395-f96-02_Onboarding screen-01.png')

W, H = 375, 812
c = Image.new('RGBA', (W, H), (255, 255, 255, 255))

shape = Image.open(os.path.join(IMG, 'onboarding_shape.png')).convert('RGBA')
sw = 240; sh = int(shape.height*sw/shape.width)
c.alpha_composite(shape.resize((sw, sh), Image.LANCZOS), (-60, -40))

glow = Image.open(os.path.join(IMG, 'onboarding_glow.png')).convert('RGBA')
gw = 300; gh = int(glow.height*gw/glow.width)
c.alpha_composite(glow.resize((gw, gh), Image.LANCZOS), (W-gw+60, H-gh+60))

# image 336 at (20,91)
ill = Image.open(os.path.join(IMG, 'onboarding_1.jpg')).convert('RGBA').resize((336,336), Image.LANCZOS)
mask = Image.new('L', (336,336), 0); ImageDraw.Draw(mask).ellipse((0,0,335,335), fill=255)
ill.putalpha(mask)
c.alpha_composite(ill, (20, 91))

def rubik(sz, wght):
    f = ImageFont.truetype(FONT, sz); f.set_variation_by_axes([wght]); return f

d = ImageDraw.Draw(c)
# title line box top 513 (28px)
tf = rubik(28, 500)
line_top = 513
asc, desc = tf.getmetrics()
ink_top = line_top + (28 - (asc+desc))//2 + (asc - 20)  # approx cap alignment
b = d.textbbox((0,0), 'Find Trusted Doctors', font=tf)
d.text(((W-(b[2]-b[0]))/2, ink_top), 'Find Trusted Doctors', font=tf, fill=(26,26,26))

# subtitle 3 lines, 14px, lh 23.24, top 555
sf = rubik(14, 400)
lines = ['Contrary to popular belief, Lorem Ipsum is not',
         'simply random text. It has roots in a piece of it',
         'over 2000 years old.']
y = 555
for ln in lines:
    b = d.textbbox((0,0), ln, font=sf)
    d.text(((W-(b[2]-b[0]))/2, y), ln, font=sf, fill=(107,114,128))
    y += 23.24

# button at (49,679) 295x54 r10
btn = Image.new('RGBA', (295,54), (0,0,0,0)); bd = ImageDraw.Draw(btn)
bd.rounded_rectangle((0,0,294,53), radius=10, fill=(16,185,129))
bf = rubik(18, 500); bb = bd.textbbox((0,0), 'Next', font=bf)
bd.text(((295-(bb[2]-bb[0]))/2, (54-(bb[3]-bb[1]))/2-3), 'Next', font=bf, fill=(255,255,255))
c.alpha_composite(btn, (49, 679))

# skip line box top 747
sk = rubik(14, 400); sb = d.textbbox((0,0),'Skip',font=sk)
d.text(((W-(sb[2]-sb[0]))/2, 747), 'Skip', font=sk, fill=(107,114,128))

ref = Image.open(REF).convert('RGB')
comp = Image.new('RGB', (W*2+20, H), (255,255,255))
comp.paste(ref, (0,0)); comp.paste(c.convert('RGB'), (W+20,0))
comp.save(os.path.join(ROOT, '.openclaw', 'tmp', 'onb_compare.png'))
print('saved compare')
