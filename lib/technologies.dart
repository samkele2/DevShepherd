import 'package:dev_shepherd/skill.dart';
import 'package:dev_shepherd/technology.dart';

class Technologies {
  List<Technology> technologies = [
    Technology("Dart", [Skill("Variable"), Skill("Strings"), Skill("Loops")]),
    Technology("Java",  [Skill("Objects"), Skill("Loops"), Skill("Iterables")]),
    Technology("Python",  [Skill("Conditionals"), Skill("Lists"), Skill("Functions")])];
}