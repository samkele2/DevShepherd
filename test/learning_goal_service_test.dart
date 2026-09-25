import 'package:flutter_test/flutter_test.dart';

import 'package:dev_shepherd/models/learning_goal.dart';

import 'fake_learning_goal_service.dart';

void main() {
  test('adds a learning goal', () async {
    final service = FakeLearningGoalService();

    await service.addLearningGoal('Learn Flutter');

    expect(service.goals.length, 1);
    expect(service.goals.first.goalName, 'Learn Flutter');
    expect(service.goals.first.isCompleted, false);
  });
  test('returns learning goals', () async {
    final service = FakeLearningGoalService();

    service.goals.add(
      LearningGoal('Learn Dart', false),
    );

    service.goals.add(
      LearningGoal('Learn Flutter', true),
    );

    final goals = await service.getLearningGoals();

    expect(goals.length, 2);
    expect(goals[0].goalName, 'Learn Dart');
    expect(goals[0].isCompleted, false);
    expect(goals[1].goalName, 'Learn Flutter');
    expect(goals[1].isCompleted, true);
  });
  test('updates a learning goal', () async {
    final service = FakeLearningGoalService();

    service.goals.add(
      LearningGoal('Learn Flutter', false),
    );

    await service.updateLearningGoal('Learn Flutter', true);

    expect(service.goals.first.isCompleted, true);
  });
  test('deletes a learning goal', () async {
    final service = FakeLearningGoalService();

    service.goals.add(
      LearningGoal('Learn Flutter', false),
    );

    await service.deleteLearningGoal('Learn Flutter');

    expect(service.goals, isEmpty);
  });
  test('marks a completed goal as incomplete', () async {
    final service = FakeLearningGoalService();

    service.goals.add(
      LearningGoal('Learn Flutter', true),
    );

    await service.updateLearningGoal('Learn Flutter', false);

    expect(service.goals.first.isCompleted, false);
  });
  test('updates only the matching learning goal', () async {
    final service = FakeLearningGoalService();

    service.goals.add(
      LearningGoal('Learn Dart', false),
    );

    service.goals.add(
      LearningGoal('Learn Flutter', false),
    );

    await service.updateLearningGoal('Learn Flutter', true);

    expect(service.goals[0].isCompleted, false);
    expect(service.goals[1].isCompleted, true);
  });
  test('deletes only the matching learning goal', () async {
    final service = FakeLearningGoalService();

    service.goals.add(
      LearningGoal('Learn Dart', false),
    );

    service.goals.add(
      LearningGoal('Learn Flutter', false),
    );

    await service.deleteLearningGoal('Learn Flutter');

    expect(service.goals.length, 1);
    expect(service.goals.first.goalName, 'Learn Dart');
  });
}