// ignore_for_file: non_constant_identifier_names

class DamageModel {
  final int? id;
  final String local;
  final String type;
  final String size;
  final String classification;
  final List photos;
  final DateTime? created_at;
  final DateTime? updated_at;

  const DamageModel({
    this.id,
    required this.local,
    required this.type,
    required this.size,
    required this.classification,
    required this.photos,
    this.created_at,
    this.updated_at,
  });
}
