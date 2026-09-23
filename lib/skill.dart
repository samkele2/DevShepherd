enum SkillLevel {
  beginner, intermediate, advanced,
}

class Skill {
  String name;
  SkillLevel level = SkillLevel.beginner;

  Skill(this.name);

  void advanceLevel() {
    if (level == SkillLevel.beginner){
      level = SkillLevel.intermediate;
    }else if (level == SkillLevel.intermediate ){
      level = SkillLevel.advanced;
  }
}
double get progress {
  if (level == SkillLevel.beginner){
    return 30/100;
  }else if (level == SkillLevel.intermediate){
    return 60/100;
  }
  return 90/100;

}
}

