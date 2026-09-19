"""One-off migration: context.w/h/r -> context.sizeOf / context.paddingOf.

Rules:
  context.r(x)              -> context.sizeOf(x)      (radius is a dimension)
  context.h(x)              -> context.paddingOf(x)   (vertical rhythm)
  context.w(x)              -> context.paddingOf(x)   when the line is clearly
                               spacing, else context.sizeOf(x) (identical value,
                               so dimensions never shift)
"""
import re
import pathlib

ROOT = pathlib.Path(r'E:\flutter route\Andriod Studio\doctor_hunt\lib')

# Lines that express spacing rather than a dimension.
SPACING = re.compile(
    r'EdgeInsets'
    r'|padding'
    r'|\bspacing\b'
    r'|runSpacing'
    r'|AxisSpacing'
    r'|separatorBuilder'
    r'|Divider'
    r'|SizedBox\(\s*(?:width|height):\s*context\.w\(\s*AppSize\.s\d+'
    r'|SizedBox\(\s*(?:width|height):\s*context\.h\('
    r'|mainAxisAlignment'
)

changed_files = 0
counts = {'sizeOf': 0, 'paddingOf': 0}

for path in sorted(ROOT.rglob('*.dart')):
    text = path.read_text(encoding='utf-8')
    if not re.search(r'context\.[whr]\(', text):
        continue

    out = []
    touched = False
    for line in text.splitlines():
        if re.search(r'context\.[whr]\(', line):
            original = line
            # r(...) is always a dimension.
            line = re.sub(r'context\.r\(', 'context.sizeOf(', line)
            # h(...) is vertical rhythm -> spacing.
            line = re.sub(r'context\.h\(', 'context.paddingOf(', line)
            # w(...) depends on the line's intent.
            repl = 'context.paddingOf(' if SPACING.search(line) else 'context.sizeOf('
            line = re.sub(r'context\.w\(', repl, line)
            if line != original:
                touched = True
                counts['sizeOf'] += line.count('context.sizeOf(')
                counts['paddingOf'] += line.count('context.paddingOf(')
        out.append(line)

    if touched:
        path.write_text('\n'.join(out) + '\n', encoding='utf-8')
        changed_files += 1

print('files changed:', changed_files)
print('occurrences now:', counts)
