import 'package:portfolio/datasource/models/contact_model.dart';
import 'package:portfolio/datasource/models/user_model.dart';

abstract class LoginRepository {
  Future<String> login(String email, String password);
  Future<UserModel?> me();
  Future<String> sendMessage(ContactModel contactModel);
}
