"""Hoist SafeArea above its Column (linear scan, no regex).

Finds `children: [` and walks back a few lines to the owning `Column(`,
then checks the first child is `SafeArea(bottom: false, child: ...)`.
"""
import pathlib

ROOT = pathlib.Path(r'E:\flutter route\Andriod Studio\doctor_hunt\lib')


def indent_of(line: str) -> str:
    return line[: len(line) - len(line.lstrip())]


changed = []
for path in sorted(ROOT.rglob('*.dart')):
    lines = path.read_text(encoding='utf-8').split('\n')
    out, i, touched = [], 0, False
    while i < len(lines):
        line = lines[i]
        if line.strip() == 'children: [':
            # Walk back to the owning Column(, stop at a blank or a closer.
            col = None
            for k in range(i - 1, max(-1, i - 9), -1):
                s = lines[k].strip()
                if s.endswith('Column('):
                    col = k
                    break
                if s == '' or s.endswith('),') or s.endswith('],'):
                    break
            if col is not None:
                j = i + 1
                while j < len(lines) and lines[j].strip() == '':
                    j += 1
                if (j + 2 < len(lines)
                        and lines[j].strip() == 'SafeArea('
                        and lines[j + 1].strip() == 'bottom: false,'
                        and lines[j + 2].strip().startswith('child: ')):
                    col_ind = indent_of(lines[col])
                    sa_ind = indent_of(lines[j])
                    # Drop everything we already emitted from the Column( down.
                    del out[len(out) - (i - col):]
                    out.append(f'{col_ind}SafeArea(')
                    out.append(f'{sa_ind}bottom: false,')
                    out.append(f'{indent_of(lines[j + 2])}child: Column(')
                    out.extend(lines[col:i])   # the Column( line + its props
                    out.append(line)           # children: [
                    i = j + 3                  # resume at the real first child
                    touched = True
                    continue
        out.append(line)
        i += 1
    if touched:
        path.write_text('\n'.join(out), encoding='utf-8')
        changed.append(path.name)

print('hoisted SafeArea in', len(changed), 'files:')
for c in changed:
    print(' ', c)
