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
}}