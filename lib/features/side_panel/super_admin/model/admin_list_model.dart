// A dummy data model to represent an administrator.
class AdminModel {
  final String id;
  final String name;
  final String phone;
  final String userId;
  final List<String> powers;

  AdminModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.userId,
    required this.powers,
  });
}
