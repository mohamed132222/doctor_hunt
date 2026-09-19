"""Repair the 8 files my hoist script corrupted.

It emitted:
    SafeArea(
        bottom: false,
          child: Column(
    return Column(
      children: [
            title: ...,          <- child widget name was dropped
and the widget name line lost. All sites are DoctorTopBar.
"""
import pathlib
import re

ROOT = pathlib.Path(r'E:\flutter route\Andriod Studio\doctor_hunt\lib')

PAT = re.compile(
    r'(?P<sa>[ \t]*)SafeArea\(\n'                # emitted SafeArea(
    r'(?P<saB>[ \t]*)bottom: false,\n'
    r'(?P<saC>[ \t]*)child: Column\(\n'
    r'(?P<ret>[ \t]*)return Column\(\n'           # the orphaned Column(
    r'(?P<ind>[ \t]*)children: \[\n'
)

fixed = []
for path in sorted(ROOT.rglob('*.dart')):
    text = path.read_text(encoding='utf-8')
    m = PAT.search(text)
    if not m:
        continue
    g = m.groupdict()
    inner = g['saC'] + '  '
    new = (
        f'{g["sa"]}return SafeArea(\n'
        f'{g["saC"]}bottom: false,\n'
        f'{g["saC"]}child: Column(\n'
        f'{g["ind"]}children: [\n'
        f'{inner}DoctorTopBar(\n'
    )
    text = text[: m.start()] + new + text[m.end():]
    path.write_text(text, encoding='utf-8')
    fixed.append(path.name)

print('repaired', len(fixed), 'files:')
for f in fixed:
    print(' ', f)
