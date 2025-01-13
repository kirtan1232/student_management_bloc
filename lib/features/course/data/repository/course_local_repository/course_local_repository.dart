import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/course_data_source.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

class CourseLocalRepository implements ICourseRepository {
  final CourseLocalRepository _courseLocalRepository;

  CourseLocalRepository(this._courseLocalRepository);

  @override
  Future<Either<Failure, void>> createCourse(CourseEntity courseEntity) {
    try {
      _courseLocalRepository.createCourse(courseEntity);
      // ignore: void_checks
      return Future.value(Right(null));
    } catch (e) {
      // ignore: void_checks
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCourse(String id) async {
    try {
      await _courseLocalRepository.deleteCourse(id);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      final courseEntity = await _courseLocalRepository.getAllCourses();
      return Right(courseEntity);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: 'Error getting all batches: $e'),
      );
    }
  }
}
