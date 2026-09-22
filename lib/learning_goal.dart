class LearningGoal {
  String goalName;
  bool isCompleted = false;

  LearningGoal(this.goalName);

  void completeGoal() {
    isCompleted = true;
  }
}