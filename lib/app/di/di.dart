import 'package:get_it/get_it.dart';
import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/batch_local_data_source.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/repository/batch_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/presentation/view_model/batch_bloc.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/course_local_data_source.dart';
import 'package:softwarica_student_management_bloc/features/course/data/repository/course_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/create_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/presentation/view_model/course_bloc.dart';
import 'package:softwarica_student_management_bloc/features/home/presentation/view_model/home_cubit.dart';
import 'package:softwarica_student_management_bloc/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();

  await _initBatchDependencies();
  await _initCourseDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initCourseDependencies() {
  // Data Source
  getIt.registerFactory<CourseLocalDataSource>(
      () => CourseLocalDataSource(hiveService: getIt<HiveService>()));

  // Repository
  getIt.registerLazySingleton<CourseLocalRepository>(() =>
      CourseLocalRepository(
          courseLocalDataSource: getIt<CourseLocalDataSource>()));

  // Usecases
  getIt.registerLazySingleton<CreateCourseUsecase>(
    () => CreateCourseUsecase(
      courseRepository: getIt<CourseLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetAllCourseUsecase>(
    () => GetAllCourseUsecase(
      courseRepository: getIt<CourseLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<DeleteCourseUsecase>(
    () => DeleteCourseUsecase(
      courseRepository: getIt<CourseLocalRepository>(),
    ),
  );

  // Bloc

  getIt.registerFactory<CourseBloc>(
    () => CourseBloc(
      getAllCourseUsecase: getIt<GetAllCourseUsecase>(),
      createCourseUsecase: getIt<CreateCourseUsecase>(),
      deleteCourseUsecase: getIt<DeleteCourseUsecase>(),
    ),
  );
}

_initBatchDependencies() async {
  // Data Source
  getIt.registerFactory<BatchLocalDataSource>(
      () => BatchLocalDataSource(hiveService: getIt<HiveService>()));

  // Repository
  getIt.registerLazySingleton<BatchLocalRepository>(() => BatchLocalRepository(
      batchLocalDataSource: getIt<BatchLocalDataSource>()));

  // Usecases
  getIt.registerLazySingleton<CreateBatchUseCase>(
    () => CreateBatchUseCase(batchRepository: getIt<BatchLocalRepository>()),
  );

  getIt.registerLazySingleton<GetAllBatchUseCase>(
    () => GetAllBatchUseCase(batchRepository: getIt<BatchLocalRepository>()),
  );

  getIt.registerLazySingleton<DeleteBatchUsecase>(
    () => DeleteBatchUsecase(batchRepository: getIt<BatchLocalRepository>()),
  );

  // Bloc
  getIt.registerFactory<BatchBloc>(
    () => BatchBloc(
      createBatchUseCase: getIt<CreateBatchUseCase>(),
      getAllBatchUseCase: getIt<GetAllBatchUseCase>(),
      deleteBatchUsecase: getIt<DeleteBatchUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initRegisterDependencies() async {
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      batchBloc: getIt<BatchBloc>(),
      courseBloc: getIt<CourseBloc>(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
