import 'package:dev_shepherd/models/learning_goal.dart';
import 'package:dev_shepherd/services/learning_goal_service.dart';

class FakeLearningGoalService implements LearningGoalService {
  final List<LearningGoal> goals = [];

  @override
  Future<List<LearningGoal>> getLearningGoals() async {
    return goals;
  }

  @override
  Future<void> addLearningGoal(String title) async {
    goals.add(
      LearningGoal(title, false),
    );
  }

  @override
  Future<void> updateLearningGoal(
      String title,
      bool completed,
      ) async {
    for (final goal in goals) {
      if (goal.goalName == title) {
        goal.isCompleted = completed;
      }
    }
  }

  @override
  Future<void> deleteLearningGoal(String title) async {
    goals.removeWhere(
          (goal) => goal.goalName == title,
    );
  }
}