// ignore_for_file: non_constant_identifier_names

class UserModel {
  final int id;
  final String name;
  final String email;
  final int cpf;
  final String role;
  final String gender;
  final String email_confirmed;
  final int cell;
  final DateTime created_at;
  final DateTime updated_at;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.cpf,
    required this.role,
    required this.gender,
    required this.email_confirmed,
    required this.cell,
    required this.created_at,
    required this.updated_at,
  });
}
