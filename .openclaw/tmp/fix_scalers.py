"""Assign each AppSize-token getter the right scaler.

Spacing  -> paddingOf : sNN tokens, *Gap / *Padding / *Offset names, and any
                        token that feeds a vertical SizedBox (unless the token
                        is a real *Height, which is a dimension).
Dimension-> sizeOf    : everything else.
"""
import pathlib
import re

ROOT = pathlib.Path(r'E:\flutter route\Andriod Studio\doctor_hunt\lib')
EXT = ROOT / 'apps/core/appsize/media_query_extension.dart'

used_vertical = set()
SZ = re.compile(r'SizedBox\(\s*height:\s*context\.(\w+)')
for p in [q for q in ROOT.rglob('*.dart') if '.openclaw' not in str(q)]:
    for m in SZ.finditer(p.read_text(encoding='utf-8')):
        used_vertical.add(m.group(1))

GETTER = re.compile(r'  double get (\w+) => (sizeOf|paddingOf)\(AppSize\.(\w+)\);')

lines = EXT.read_text(encoding='utf-8').split('\n')
changed = []
for i, line in enumerate(lines):
    m = GETTER.match(line)
    if not m:
        continue
    name, fn, tok = m.group(1), m.group(2), m.group(3)

    is_spacing_token = name.startswith('s') and name[1:].isdigit()
    is_spacing_name = any(k in name for k in ('Gap', 'Padding', 'Offset'))
    is_vertical_gap = name in used_vertical and not tok.endswith('Height')

    want = 'paddingOf' if (is_spacing_token or is_spacing_name or is_vertical_gap) else 'sizeOf'
    if fn != want:
        lines[i] = f'  double get {name} => {want}(AppSize.{tok});'
        changed.append(f'{name}: {fn} -> {want}')

EXT.write_text('\n'.join(lines), encoding='utf-8')
print('corrected', len(changed))
for c in changed[:20]:
    print(' ', c)
