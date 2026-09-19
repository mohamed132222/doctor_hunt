"""Restore the AppSize imports the earlier `dart fix` stripped, and finish the
one call site the inline pass missed.
"""
import os
import pathlib
import re

ROOT = pathlib.Path(r'E:\flutter route\Andriod Studio\doctor_hunt\lib')
TARGET = ROOT / 'apps/core/appsize/app_size.dart'


def rel_import(frm: pathlib.Path) -> str:
    rel = os.path.relpath(TARGET, frm.parent).replace('\\', '/')
    return f"import '{rel}';"


fixed = []
for p in [q for q in ROOT.rglob('*.dart') if '.openclaw' not in str(q)]:
    text = p.read_text(encoding='utf-8')
    needs = 'AppSize.' in text
    has = re.search(r"import '[^']*app_size\.dart';", text)
    if not needs or has:
        continue
    line = rel_import(p)
    m = re.search(r"^import '[^']*';\n", text, re.M)
    text = text[:m.end()] + line + '\n' + text[m.end():]
    p.write_text(text, encoding='utf-8')
    fixed.append(p.name)
print('imports restored:', len(fixed))

# The one call site that survived the inline pass.
sheet = ROOT / 'apps/core/widgets/app_sheet.dart'
s = sheet.read_text(encoding='utf-8')
if 'context.sheetSubtitleContentGap' in s:
    s = s.replace('context.sheetSubtitleContentGap',
                  'context.paddingOf(AppSize.sheetSubtitleContentGap)')
    sheet.write_text(s, encoding='utf-8')
    print('app_sheet call site finished')
