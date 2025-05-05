class ContactModel {
  ContactModel({
    required this.name,
    required this.email,
    required this.message,
  });
  final String name;
  final String email;
  final String message;

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'message': message};
  }
}
