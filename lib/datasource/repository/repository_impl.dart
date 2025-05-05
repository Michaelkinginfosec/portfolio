import 'package:dio/dio.dart';
import 'package:portfolio/datasource/models/contact_model.dart';
import 'package:portfolio/datasource/models/user_model.dart';
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
        options: Options(extra: {'withCredentials': true}),
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

  @override
  Future<UserModel?> me() async {
    try {
      final response = await dio.get('/auth/me');

      if (response.statusCode == 200) {
        if (response.data != null) {
          return UserModel.fromJson(response.data);
        } else {
          throw Exception("User data is null");
        }
      } else {
        throw Exception(
          "Can't reach user, Status Code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'failed';

        if (statusCode == 401) {
          throw Exception('Unauthorized access (401)');
        } else {
          throw Exception('Server returned an error: $message');
        }
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
          'Network error. Please check your internet connection.',
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('The server took too long to respond.');
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw Exception('Failed to send request, check your connection.');
      } else {
        throw Exception('Something went wrong: ${e.message}');
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }

  @override
  Future<String> sendMessage(ContactModel contactModel) async {
    try {
      final response = await dio.post('/contact', data: contactModel.toJson());

      if (response.statusCode == 201) {
        return "Message sent successfully";
      } else {
        throw Exception("Failed to send message");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'failed';

        if (statusCode == 401) {
          throw Exception('Unauthorized access (401)');
        } else {
          throw Exception('Server returned an error: $message');
        }
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
          'Network error. Please check your internet connection.',
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('The server took too long to respond.');
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw Exception('Failed to send request, check your connection.');
      } else {
        throw Exception('Something went wrong: ${e.message}');
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
