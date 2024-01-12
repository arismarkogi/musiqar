import 'package:flutter/foundation.dart';
import 'new_course_page2.dart';

class CourseInfoProvider extends ChangeNotifier {
  String courseName = '';
  String category = '';
  String shortDescription = '';

  List<ChapterInfo> _chapterInputs = [];

  List<ChapterInfo> get chapterInputs => _chapterInputs;

  void updateCourseInfo(String newName, String newCategory, String newDescription) {
    courseName = newName;
    category = newCategory;
    shortDescription = newDescription;
    notifyListeners();
  }

  void addChapter(ChapterInfo chapter) {
    _chapterInputs.add(chapter);
    notifyListeners();
  }

}

