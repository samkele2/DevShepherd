import 'package:dev_shepherd/learning_goal.dart';

List<LearningGoal> learningGoals = [];

int get completedGoals {
  int count = 0;
  for (LearningGoal goal in learningGoals) {
    if (goal.isCompleted){
      count ++;
    }
  }return count;
}
int get totalGoals {return learningGoals.length;}

double get progress {
  if (totalGoals == 0){
    return 0.0;
  } return completedGoals / totalGoals;
}
