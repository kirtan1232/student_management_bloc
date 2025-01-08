import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/Course/domain/entity/Course_entity.dart';

abstract interface class ICourseRepository {
  Future<Either<Failure, List<CourseEntity>>> getCoursees();
  Future<Either<Failure, void>> createCourse(CourseEntity Course);
  Future<Either<Failure, void>> deleteCourse(String id);
}
