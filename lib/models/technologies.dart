import 'package:dev_shepherd/models/skill.dart';
import 'package:dev_shepherd/models/technology.dart';

class Technologies {
  List<Technology> technologies = [
    Technology("Dart", [Skill("Variable"), Skill("Strings"), Skill("Loops")]),
    Technology("Java",  [Skill("Objects"), Skill("Loops"), Skill("Iterables")]),
    Technology("Python",  [Skill("Conditionals"), Skill("Lists"), Skill("Functions")])];
}