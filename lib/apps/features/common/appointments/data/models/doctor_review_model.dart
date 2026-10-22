class DoctorReview {
  const DoctorReview({
    required this.patientName,
    required this.rating,
    required this.date,
    this.comment,
  });

  final String patientName;
  final double rating;

  final String? comment;

  final DateTime date;

  factory DoctorReview.fromRow(Map<String, dynamic> row) => DoctorReview(
    patientName: row['patient_name'] as String? ?? '',
    rating: (row['rating'] as num?)?.toDouble() ?? 0,
    comment: row['review_comment'] as String?,
    date: DateTime.parse(row['created_at'] as String),
  );
}
