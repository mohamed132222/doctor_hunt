"""Revert the token getters: expand `context.token` back to
`context.sizeOf(AppSize.token)` / `context.paddingOf(AppSize.token)`,
using whatever scaler each getter currently declares.
"""
import pathlib
import re

ROOT = pathlib.Path(r'E:\flutter route\Andriod Studio\doctor_hunt\lib')
EXT = ROOT / 'apps/core/appsize/media_query_extension.dart'

GETTER = re.compile(r'  double get (\w+) => (sizeOf|paddingOf)\(AppSize\.(\w+)\);')
src = EXT.read_text(encoding='utf-8')
fns = {m.group(1): m.group(2) for m in GETTER.finditer(src)}
if not fns:
    raise SystemExit('no getters found')
print('getters to inline:', len(fns))

# 1. Expand call sites.
expanded = 0
for p in [q for q in ROOT.rglob('*.dart') if '.openclaw' not in str(q)]:
    if p == EXT:
        continue
    text = orig = p.read_text(encoding='utf-8')
    for name in sorted(fns, key=len, reverse=True):
        text = re.sub(
            r'\bcontext\.' + re.escape(name) + r'\b(?!\s*\()',
            f'context.{fns[name]}(AppSize.{name})',
            text,
        )
    if text != orig:
        p.write_text(text, encoding='utf-8')
        expanded += 1
print('files with call sites expanded:', expanded)

# 2. Drop the generated getter block from the extension.
start = src.find('  // ── AppSize tokens')
if start != -1:
    end = src.rindex('}')
    src = src[:start].rstrip() + '\n}\n'
    EXT.write_text(src, encoding='utf-8')
    print('getter block removed')
