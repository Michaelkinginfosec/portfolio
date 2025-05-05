import 'package:dio/dio.dart';
import 'package:dio_web_adapter/dio_web_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/datasource/repository/project_repository.dart';
import 'package:portfolio/datasource/repository/project_repository_impl.dart';
import 'package:portfolio/datasource/repository/repository_impl.dart';
import 'package:portfolio/datasource/repository/respository.dart';

final GetIt getIt = GetIt.instance;

Future<void> depen() async {
  //Dio
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstansts.apiUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    )..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true),
  );

  //repository

  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImp(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(getIt<Dio>()),
  );
}
