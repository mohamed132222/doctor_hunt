import 'package:equatable/equatable.dart';

class DoctorAvailability extends Equatable {
  const DoctorAvailability({
    required this.workingDays,
    required this.startMinute,
    required this.endMinute,
    required this.slotMinutes,
  });

  final Set<int> workingDays;

  final int startMinute;

  final int endMinute;

  final int slotMinutes;

  static const DoctorAvailability standard = DoctorAvailability(
    workingDays: <int>{
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
    },
    startMinute: 9 * minutesPerHour,
    endMinute: 17 * minutesPerHour,
    slotMinutes: 30,
  );

  static const int minutesPerHour = 60;
  static const int minutesPerDay = 24 * minutesPerHour;

  bool worksOn(int weekday) => workingDays.contains(weekday);

  bool get isBookable =>
      workingDays.isNotEmpty &&
      slotMinutes > 0 &&
      endMinute > startMinute &&
      endMinute - startMinute >= slotMinutes;

  int get slotsPerDay {
    if (!isBookable) return 0;
    return (endMinute - startMinute) ~/ slotMinutes;
  }

  List<int> slotStartsFor(int weekday) {
    if (!worksOn(weekday) || !isBookable) return const <int>[];
    return <int>[
      for (
        int minute = startMinute;
        minute + slotMinutes <= endMinute;
        minute += slotMinutes
      )
        minute,
    ];
  }

  DoctorAvailability copyWith({
    Set<int>? workingDays,
    int? startMinute,
    int? endMinute,
    int? slotMinutes,
  }) {
    return DoctorAvailability(
      workingDays: workingDays ?? this.workingDays,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      slotMinutes: slotMinutes ?? this.slotMinutes,
    );
  }

  DoctorAvailability toggleDay(int weekday) {
    final next = Set<int>.of(workingDays);
    if (!next.remove(weekday)) next.add(weekday);
    return copyWith(workingDays: next);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'workingDays': workingDays.toList()..sort(),
    'startMinute': startMinute,
    'endMinute': endMinute,
    'slotMinutes': slotMinutes,
  };

  factory DoctorAvailability.fromJson(Map<String, dynamic> json) {
    final days = (json['workingDays'] as List?) ?? const <dynamic>[];
    return DoctorAvailability(
      workingDays: <int>{for (final d in days) (d as num).toInt()},
      startMinute:
          (json['startMinute'] as num?)?.toInt() ?? standard.startMinute,
      endMinute: (json['endMinute'] as num?)?.toInt() ?? standard.endMinute,
      slotMinutes:
          (json['slotMinutes'] as num?)?.toInt() ?? standard.slotMinutes,
    );
  }

  @override
  List<Object?> get props => [workingDays, startMinute, endMinute, slotMinutes];
}
