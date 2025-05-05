import 'package:file_picker/file_picker.dart';

class ProjectModel {
  ProjectModel({
    required this.image,
    required this.title,
    required this.subTitle,
    this.type,
    this.imageFile,
    this.androidLink,
    this.iosLink,
    this.webLink,
    this.githubLink,
  });

  final String image;
  final PlatformFile? imageFile;
  final String title;
  final String subTitle;
  final String? type;
  final String? androidLink;
  final String? iosLink;
  final String? webLink;
  final String? githubLink;

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      subTitle: json['subTitle'] ?? '',
      type: json['type'] ?? '',
      androidLink: json['androidLink'] as String?,
      iosLink: json['iosLink'] as String?,
      webLink: json['webLink'] as String?,
      githubLink: json['githubLink'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'subTitle': subTitle,
      'androidLink': androidLink,
      'iosLink': iosLink,
      'webLink': webLink,
      'githubLink': githubLink,
    };
  }
}
