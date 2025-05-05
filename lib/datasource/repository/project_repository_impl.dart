import 'package:dio/dio.dart';
import 'package:portfolio/datasource/models/project_models.dart';
import 'package:portfolio/datasource/repository/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Dio dio;
  ProjectRepositoryImpl(this.dio);
  @override
  Future<String> addProject(String type, ProjectModel projectModel) async {
    try {
      if (projectModel.imageFile == null) {
        throw Exception("No image file selected");
      }

      final uploadFormData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          projectModel.imageFile!.bytes!,
          filename: projectModel.imageFile!.name,
        ),
      });

      final uploadResponse = await dio.post(
        '/upload/image',
        data: uploadFormData,
      );

      if (uploadResponse.statusCode != 201) {
        throw Exception("Failed to upload image");
      }

      final imageUrl = uploadResponse.data['imageUrl'];
      if (imageUrl == null) {
        throw Exception("Image URL not returned from server");
      }

      final projectData = {
        'image': imageUrl,
        'title': projectModel.title,
        'subTitle': projectModel.subTitle,
        if (projectModel.androidLink != null)
          'androidLink': projectModel.androidLink,
        if (projectModel.iosLink != null) 'iosLink': projectModel.iosLink,
        if (projectModel.webLink != null) 'webLink': projectModel.webLink,
        if (projectModel.githubLink != null)
          'githubLink': projectModel.githubLink,
      };

      final response = await dio.post(
        '/project/$type',
        data: projectData,
        options: Options(extra: {'withCredentials': true}),
      );

      if (response.statusCode == 201) {
        return "Project Added Successfully";
      } else {
        throw Exception(
          "Failed to add project. Status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception(
          "Unauthorized: Please check your credentials or login session.",
        );
      }
      throw Exception("Failed to add project: ${e.message}");
    } catch (error) {
      throw Exception("Unexpected error occurred: $error");
    }
  }

  @override
  Future<List<ProjectModel>> getAllProject(String type) async {
    try {
      final response = await dio.get('/project/$type');
      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data;
        return dataList.map((json) => ProjectModel.fromJson(json)).toList();
      } else {
        throw Exception(
          "Failed to fetch projects. Status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      throw Exception("Failed to fetch projects: ${e.message}");
    } catch (error) {
      throw Exception("Unexpected error occurred: $error");
    }
  }
}
