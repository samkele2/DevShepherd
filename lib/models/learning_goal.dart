class LearningGoal {
  String goalName;
  bool isCompleted = false;

  LearningGoal(this.goalName, this.isCompleted);

  void completeGoal() {
    isCompleted = true;
  }
}