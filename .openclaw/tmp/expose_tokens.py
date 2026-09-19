"""Give AppSize tokens a getter on the extension, so call sites read
`context.s16` instead of `context.paddingOf(AppSize.s16)`.

Each token keeps whichever scaler it's already using in the codebase, so no
spacing accidentally becomes a dimension (or vice versa).
"""
import collections
import pathlib
import re

ROOT = pathlib.Path(r'E:\flutter route\Andriod Studio\doctor_hunt\lib')
EXT = ROOT / 'apps/core/appsize/media_query_extension.dart'
CALL = re.compile(r'context\.(sizeOf|paddingOf)\(\s*AppSize\.(\w+)\s*\)')

files = [p for p in ROOT.rglob('*.dart') if '.openclaw' not in str(p)]

# 1. Which scaler does each token already use?
usage = collections.defaultdict(set)
for p in files:
    for m in CALL.finditer(p.read_text(encoding='utf-8')):
        usage[m.group(2)].add(m.group(1))

# A token used both ways (rare) keeps the dimension scaler: safer to under-space
# than to blow up a box.
method = {
    tok: ('paddingOf' if ms == {'paddingOf'} else 'sizeOf')
    for tok, ms in usage.items()
}
print('tokens to expose:', len(method))

# 2. Emit the getters.
spacing = sorted([t for t, m in method.items() if m == 'paddingOf'])
dims = sorted([t for t, m in method.items() if m == 'sizeOf'])
block = [
    '\n  // ── AppSize tokens ───────────────────────────────────────────────────────',
    '  // Short forms so call sites read `context.s16` rather than',
    '  // `context.paddingOf(AppSize.s16)`. Each keeps the scaler it had before.',
    '  //',
    '  // Spacing (padding scale):',
]
block += [f'  double get {t} => paddingOf(AppSize.{t});' for t in spacing]
block += ['', '  // Dimensions (width scale):']
block += [f'  double get {t} => sizeOf(AppSize.{t});' for t in dims]
block.append('')

src = EXT.read_text(encoding='utf-8')
assert 'double get s2 =>' not in src, 'getters already present'
# insert before the extension's final closing brace
idx = src.rstrip().rfind('}')
src = src[:idx] + '\n'.join(block) + src[idx:]
EXT.write_text(src, encoding='utf-8')

# 3. Rewrite call sites.
n = 0
for p in files:
    t = orig = p.read_text(encoding='utf-8')
    t = CALL.sub(lambda m: f'context.{m.group(2)}', t)
    if t != orig:
        p.write_text(t, encoding='utf-8')
        n += len(CALL.findall(orig))
print('call sites rewritten:', n)
