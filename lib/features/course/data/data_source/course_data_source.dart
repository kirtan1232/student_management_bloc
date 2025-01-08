import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

abstract interface class ICourseRepository {
  Future<List<CourseEntity>> getCourses();
  Future<void> createCourse(CourseEntity course);
  Future<void> deleteCOurse(String id);
}
