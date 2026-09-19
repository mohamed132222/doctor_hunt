"""Ensure every file that uses AppSize / the extensions imports both."""
import os
import pathlib

ROOT = pathlib.Path(r'E:\flutter route\Andriod Studio\doctor_hunt\lib')
APP_SIZE = ROOT / 'apps/core/appsize/app_size.dart'
EXT = ROOT / 'apps/core/appsize/media_query_extension.dart'


def add_import(text: str, line: str) -> str:
    """Insert `line` after the last existing import, or at the top."""
    lines = text.split('\n')
    idx = None
    for i, l in enumerate(lines):
        if l.strip().startswith('import '):
            idx = i
    if idx is None:
        return line + '\n' + text
    lines.insert(idx + 1, line)
    return '\n'.join(lines)


fixed = []
for p in sorted(q for q in ROOT.rglob('*.dart') if '.openclaw' not in str(q)):
    if p in (APP_SIZE, EXT):
        continue
    text = orig = p.read_text(encoding='utf-8')

    if 'AppSize.' in text and 'app_size.dart' not in text:
        rel = os.path.relpath(APP_SIZE, p.parent).replace('\\', '/')
        text = add_import(text, f"import '{rel}';")

    uses_ext = ('context.paddingOf(' in text or 'context.sizeOf(' in text
                or 'screenWidth' in text or 'screenHeight' in text)
    if uses_ext and 'media_query_extension.dart' not in text:
        rel = os.path.relpath(EXT, p.parent).replace('\\', '/')
        text = add_import(text, f"import '{rel}';")

    if text != orig:
        p.write_text(text, encoding='utf-8')
        fixed.append(str(p.relative_to(ROOT)))

print('files fixed:', len(fixed))
for f in fixed[:12]:
    print('  ', f)
