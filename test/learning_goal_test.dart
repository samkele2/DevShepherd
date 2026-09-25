import 'package:flutter_test/flutter_test.dart';
import 'package:dev_shepherd/models/learning_goal.dart';

void main() {
  group('LearningGoal', () {
    test('creates a learning goal as incomplete', () {
      final goal = LearningGoal('Learn Firebase', false);

      expect(goal.goalName, 'Learn Firebase');
      expect(goal.isCompleted, false);
    });

    test('creates a learning goal as completed', () {
      final goal = LearningGoal('Learn Dart', true);

      expect(goal.goalName, 'Learn Dart');
      expect(goal.isCompleted, true);
    });

    test('completeGoal marks the goal as completed', () {
      final goal = LearningGoal('Learn Flutter', false);

      goal.completeGoal();

      expect(goal.isCompleted, true);
    });

    test('completed goal remains completed', () {
      final goal = LearningGoal('Learn Dart', true);

      goal.completeGoal();

      expect(goal.isCompleted, true);
    });
  });
}