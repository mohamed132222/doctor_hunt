import os
from PIL import Image

ATT = r'E:\flutter route\Andriod Studio\doctor_hunt\.openclaw-attachments'

def analyze(name, path):
    im = Image.open(path).convert('RGBA')
    w, h = im.size
    print('====', name, im.size)
    a = im.getchannel('A')
    # center opacity
    cx, cy = w//2, h//2
    print('center pixel', im.getpixel((cx, cy)))
    # sample a grid, report distinct opaque colors
    opaque = []
    for y in range(h):
        for x in range(w):
            r, g, b, aa = im.getpixel((x, y))
            if aa > 200:
                opaque.append((r, g, b))
    n = len(opaque)
    print('opaque px', n, 'of', w*h, f'({100*n/(w*h):.1f}%)')
    if opaque:
        rs = sum(p[0] for p in opaque)//n
        gs = sum(p[1] for p in opaque)//n
        bs = sum(p[2] for p in opaque)//n
        print('avg opaque RGB', (rs, gs, bs), hex(rs), hex(gs), hex(bs))
        # unique-ish colors (quantized)
        uniq = {}
        for p in opaque:
            key = (p[0]//16, p[1]//16, p[2]//16)
            uniq[key] = uniq.get(key, 0) + 1
        top = sorted(uniq.items(), key=lambda kv: -kv[1])[:5]
        for k, c in top:
            print('  color bucket', (k[0]*16, k[1]*16, k[2]*16), 'count', c)

bg = os.path.join(ATT, '20260912-205954-6ed5511f-8d3-bg.png')
vec = os.path.join(ATT, '20260912-205954-c07ec83c-f3a-splash_vector.png')
txt = os.path.join(ATT, '20260912-205954-7a947d0a-141-splash_text.png')
analyze('bg', bg)
analyze('vector', vec)
analyze('text', txt)

# bg: sample corner colors and their alpha, plus what's over the whole canvas
im = Image.open(bg).convert('RGBA')
w, h = im.size
for label, (x, y) in {'TL': (8, 8), 'TR': (w-8, 8), 'BL': (8, h-8), 'BR': (w-8, h-8), 'C': (w//2, h//2)}.items():
    print('bg', label, im.getpixel((x, y)))

# vector: is center hollow? sample ring vs center
v = Image.open(vec).convert('RGBA')
vw, vh = v.size
print('vector center 3x3:')
for y in range(vh//2-1, vh//2+2):
    row = [v.getpixel((x, y)) for x in range(vw//2-1, vw//2+2)]
    print(' ', row)
print('vector edge midpoints:', v.getpixel((vw//2, 0)), v.getpixel((vw//2, vh-1)), v.getpixel((0, vh//2)), v.getpixel((vw-1, vh//2)))
