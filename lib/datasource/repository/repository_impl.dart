import 'package:dio/dio.dart';
import 'package:portfolio/datasource/repository/respository.dart';

class LoginRepositoryImp implements LoginRepository {
  final Dio dio;
  LoginRepositoryImp(this.dio);
  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 201 && response.data != null) {
        return "Login Successful";
      } else {
        throw Exception("Login failed, please try again.");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Login failed';

        if (statusCode == 401) {
          throw Exception('Invalid email or password');
        } else {
          throw Exception(message);
        }
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
          'Network error. Please check your internet connection.',
        );
      } else {
        throw Exception('Something went wrong: ${e.message}');
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
