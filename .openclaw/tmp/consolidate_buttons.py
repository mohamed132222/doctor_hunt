"""Replace the three duplicated private buttons with the shared PrimaryButton."""
import pathlib

BASE = pathlib.Path(
    r'E:\flutter route\Andriod Studio\doctor_hunt\lib\apps\features'
)
IMPORT_LINE = "import '../../../../core/widgets/primary_button.dart';\n"

JOBS = [
    dict(
        path=BASE / 'appointment/presentation/widgets/appointment_body.dart',
        cls='_NextButton',
        usage='_NextButton(onTap: _submit),',
        repl=(
            'PrimaryButton(\n'
            '                label: AppStrings.next,\n'
            '                height: AppSize.appointmentNextHeight,\n'
            '                radius: AppSize.bookingActionRadius,\n'
            '                fontSize: AppSize.s16,\n'
            '                onPressed: _submit,\n'
            '              ),'
        ),
        drop_import="import 'appointment_doctor_card.dart';",
    ),
    dict(
        path=BASE / 'appointment/presentation/widgets/schedule_body.dart',
        cls='_ConfirmButton',
        usage='_ConfirmButton(onTap: _confirm),',
        repl=(
            'PrimaryButton(\n'
            '                    label: AppStrings.confirmButton,\n'
            '                    height: AppSize.confirmHeight,\n'
            '                    radius: AppSize.bookingActionRadius,\n'
            '                    fontSize: AppSize.s16,\n'
            '                    onPressed: _confirm,\n'
            '                  ),'
        ),
        drop_import="import 'month_calendar.dart';",
    ),
    dict(
        path=BASE / 'booking/presentation/widgets/booking_body.dart',
        cls='_ConfirmButton',
        usage=None,  # multi-line usage, handled explicitly
        repl=None,
        drop_import=None,
    ),
]


def drop_class(text: str, cls: str) -> str:
    """Remove `class <cls> ... }` including its trailing blank line."""
    start = text.index(f'class {cls} extends StatelessWidget {{')
    i = text.index('{', start)
    depth = 0
    for j in range(i, len(text)):
        if text[j] == '{':
            depth += 1
        elif text[j] == '}':
            depth -= 1
            if depth == 0:
                end = j + 1
                break
    # swallow a following blank line
    while end < len(text) and text[end] == '\n':
        end += 1
    return text[:start] + text[end:]


for job in JOBS:
    p = job['path']
    text = p.read_text(encoding='utf-8')

    if job['usage']:
        assert job['usage'] in text, f"usage not found in {p.name}"
        text = text.replace(job['usage'], job['repl'])
    else:
        old = """          _ConfirmButton(
            label: AppStrings.bookNowWithCount(_selectedSlots.length),
            onTap: () => context.pushNamed(
              RouteName.appointment,
              pathParameters: {'doctorId': widget.doctor.id},
            ),
          ),"""
        new = """          PrimaryButton(
            label: AppStrings.bookNowWithCount(_selectedSlots.length),
            height: AppSize.bookingActionHeight,
            radius: AppSize.bookingActionRadius,
            onPressed: () => context.pushNamed(
              RouteName.appointment,
              pathParameters: {'doctorId': widget.doctor.id},
            ),
          ),"""
        assert old in text, f"usage not found in {p.name}"
        text = text.replace(old, new)

    assert f'class {job["cls"]}' in text, f"class not found in {p.name}"
    text = drop_class(text, job['cls'])
    assert job['cls'] not in text, f"stale reference in {p.name}"

    if IMPORT_LINE not in text:
        anchor = "import '../../../../core/constants/app_strings.dart';\n"
        assert anchor in text, f"no import anchor in {p.name}"
        text = text.replace(anchor, anchor + IMPORT_LINE, 1)

    p.write_text(text, encoding='utf-8')
    print('rewrote', p.name)
