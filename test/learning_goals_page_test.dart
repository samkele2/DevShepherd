import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dev_shepherd/pages/learning_goals_page.dart';
import 'package:dev_shepherd/data/learning_goal_data.dart';
import 'package:dev_shepherd/models/learning_goal.dart';
import 'fake_learning_goal_service.dart';

void main() {
  testWidgets('shows empty state when there are no learning goals',
          (tester) async {
        learningGoals.clear();

        await tester.pumpWidget(
          MaterialApp(
            home: LearningGoalsPage(
              loadFromFirebase: false,
              learningGoalService: FakeLearningGoalService(),
            ),
          ),
        );

        expect(
          find.text('No learning goals. Tap + to add a learning goal.'),
          findsOneWidget,
        );
      });

  testWidgets('displays an active learning goal', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Flutter', false),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );
    await tester.tap(find.text('Active Goals'));
    await tester.pumpAndSettle();

    expect(find.text('Learn Flutter'), findsOneWidget);
  });
  testWidgets('displays a completed learning goal', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Dart', true),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.text('Completed Goals'));
    await tester.pumpAndSettle();

    expect(
      find.text('Learn Dart'),
      findsOneWidget,
    );
  });
  testWidgets('displays correct progress', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Flutter', false),
    );

    learningGoals.add(
      LearningGoal('Learn Dart', true),
    );

    await tester.pumpWidget(
        MaterialApp(
          home: LearningGoalsPage(
            loadFromFirebase: false,
            learningGoalService: FakeLearningGoalService(),
          ),
        ),
    );

    expect(
      find.text('1 / 2 goals completed'),
      findsOneWidget,
    );
  });
  testWidgets('completes a learning goal', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Flutter', false),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.text('Active Goals'));
    await tester.pumpAndSettle();

    final checkbox = find.byType(CheckboxListTile);

    expect(checkbox, findsOneWidget);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(
      learningGoals.first.isCompleted,
      true,
    );
  });
  testWidgets('deletes a learning goal', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Firebase', false),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.text('Active Goals'));
    await tester.pumpAndSettle();

    expect(
      find.text('Learn Firebase'),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(
      find.text('Learn Firebase'),
      findsNothing,
    );

    expect(
      learningGoals,
      isEmpty,
    );
  });
  testWidgets('shows empty state when there are no completed goals', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Flutter', false),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.text('Completed Goals'));
    await tester.pumpAndSettle();

    expect(
      find.text('No completed goals'),
      findsOneWidget,
    );
  });testWidgets('shows empty state when there are no active goals', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Dart', true),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.text('Active Goals'));
    await tester.pumpAndSettle();

    expect(
      find.text('No active goals.'),
      findsOneWidget,
    );
  });
  testWidgets('opens add learning goal dialog', (tester) async {
    learningGoals.clear();

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(
      find.text('Add learning goal'),
      findsOneWidget,
    );

    expect(
      find.byType(TextField),
      findsOneWidget,
    );
  });
  testWidgets('cancels adding a learning goal', (tester) async {
    learningGoals.clear();

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField),
      'Learn Flutter',
    );

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(
      find.text('Add learning goal'),
      findsNothing,
    );

    expect(
      learningGoals,
      isEmpty,
    );
  });
  testWidgets('adds a learning goal', (tester) async {
    final fakeService = FakeLearningGoalService();

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: fakeService,
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField),
      'Learn Flutter',
    );

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(fakeService.goals.length, 1);
    expect(fakeService.goals.first.goalName, 'Learn Flutter');
  });
  testWidgets('completes a learning goal', (tester) async {
    learningGoals.clear();

    final fakeService = FakeLearningGoalService();
    fakeService.goals.add(
      LearningGoal('Learn Flutter', false),
    );

  });testWidgets('completes a learning goal', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Flutter', false),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );
    await tester.tap(find.text('Active Goals'));
    await tester.pumpAndSettle();

    expect(find.byType(CheckboxListTile), findsOneWidget);

    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();

    expect(learningGoals.first.isCompleted, true);
  });
  testWidgets('deletes a learning goal', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Flutter', false),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.text('Active Goals'));
    await tester.pumpAndSettle();

    expect(find.text('Learn Flutter'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(find.text('Learn Flutter'), findsNothing);
  });
  testWidgets('shows completed goal in completed goals section', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Flutter', true),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.text('Completed Goals'));
    await tester.pumpAndSettle();

    expect(find.text('Learn Flutter'), findsOneWidget);
  });
  testWidgets('does not show active goal in completed goals section', (tester) async {
    learningGoals.clear();

    learningGoals.add(
      LearningGoal('Learn Flutter', false),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: FakeLearningGoalService(),
        ),
      ),
    );

    await tester.tap(find.text('Completed Goals'));
    await tester.pumpAndSettle();

    expect(find.text('No completed goals'), findsOneWidget);
    expect(find.text('Learn Flutter'), findsNothing);
  });
  testWidgets('does not add an empty learning goal', (tester) async {
    learningGoals.clear();

    final fakeService = FakeLearningGoalService();

    await tester.pumpWidget(
      MaterialApp(
        home: LearningGoalsPage(
          loadFromFirebase: false,
          learningGoalService: fakeService,
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(fakeService.goals, isEmpty);
  });

}