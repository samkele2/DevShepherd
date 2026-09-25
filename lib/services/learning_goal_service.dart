
import '../models/learning_goal.dart';

abstract class LearningGoalService {
  Future<List<LearningGoal>> getLearningGoals();

  Future<void> addLearningGoal(String title);

  Future<void> updateLearningGoal(
      String title,
      bool completed,
      );

  Future<void> deleteLearningGoal(String title);
}