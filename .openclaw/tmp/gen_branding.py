import os
from PIL import Image

ATT = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments'
OUT = r'E:\flutter route\Andriod Studio\doctor_hunt\assets\splash'

txt = Image.open(os.path.join(ATT, '20260912-205954-7a947d0a-141-splash_text.png')).convert('RGBA')

def to_white(im):
    r, g, b, a = im.split()
    w = Image.new('RGBA', im.size, (255, 255, 255, 255))
    w.putalpha(a)
    return w

# Android 12 branding: 800x320 with centered wordmark
BRAND = (800, 320)
brand = Image.new('RGBA', BRAND, (0, 0, 0, 0))
# scale wordmark to ~70% width, preserve aspect
ww = int(BRAND[0] * 0.7)
wh = int(ww * txt.height / txt.width)
wm = to_white(txt).resize((ww, wh), Image.LANCZOS)
brand.alpha_composite(wm, ((BRAND[0] - ww) // 2, (BRAND[1] - wh) // 2))
brand.save(os.path.join(OUT, 'branding_android12.png'))
print('saved branding_android12.png', BRAND, 'wordmark', (ww, wh))
