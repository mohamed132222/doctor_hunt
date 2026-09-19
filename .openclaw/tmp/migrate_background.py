"""Scaffold(body: EllipseBackground(child: X)) -> AppBackground(child: X).

Shape-based: the formatted wrapper is always
    return Scaffold(
      body: EllipseBackground(
        child: ...
      ),
    );
so we replace the head and drop the now-redundant closing line.
"""
import pathlib

ROOT = pathlib.Path(r'E:\flutter route\Andriod Studio\doctor_hunt\lib')

HEAD_OLD = 'Scaffold(\n      body: EllipseBackground(\n        child:'
HEAD_NEW = 'AppBackground(\n      child:'
TAIL_OLD = '\n      ),\n    );'
TAIL_NEW = '\n    );'

changed = []
for path in sorted(ROOT.rglob('*.dart')):
    if path.name == 'ellipse_background.dart':
        continue

    text = path.read_text(encoding='utf-8')
    if HEAD_OLD not in text:
        continue

    text = text.replace(HEAD_OLD, HEAD_NEW)

    # The wrapper's own closing paren is the last "      ),\n    );" in file.
    idx = text.rfind(TAIL_OLD)
    assert idx != -1, path
    text = text[:idx] + TAIL_NEW + text[idx + len(TAIL_OLD):]

    text = text.replace('ellipse_background.dart', 'app_background.dart')
    path.write_text(text, encoding='utf-8')
    changed.append(path.name)

print('migrated', len(changed), 'screens:')
for c in changed:
    print(' ', c)
