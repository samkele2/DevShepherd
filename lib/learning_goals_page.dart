import 'package:flutter/material.dart';
import 'package:dev_shepherd/learning_goal.dart';

class LearningGoalsPage extends StatefulWidget {
  const LearningGoalsPage({super.key});

  @override
  State<LearningGoalsPage> createState() => _LearningGoalsPageState();
}
class _LearningGoalsPageState extends State<LearningGoalsPage> {
  List<LearningGoal> learningGoals = [];

  void _addLearningGoal(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add learning goal"),
              content: TextField(
                controller: _textEditingController,
              ),
              actions: [
                TextButton(onPressed: () {
                  setState(() {
                    learningGoals.add(LearningGoal(_textEditingController.text));
                  });
                  Navigator.pop(context);

                }, child: Text("Add")),
                TextButton(onPressed: () {
                  Navigator.pop(context);  // closes the dialog
                }, child: Text("Cancel")),
              ]
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Goals Page'),
      ),
      body: Column(
        children: [
          const Text('Learning Goals',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              )),
          for (LearningGoal goal in learningGoals)
            CheckboxListTile(
              title: Text(goal.goalName),
              value: goal.isCompleted,
              onChanged: (newValue) {
                setState(() {
                  goal.isCompleted = newValue ?? false;
                });
              },
              secondary: IconButton(onPressed: () {
                setState(() {
                  learningGoals.remove(goal);
                });
              },
                  icon: const Icon(Icons.delete_outline)),
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addLearningGoal(context);
        },
        tooltip: 'Add Learning Goal',
        child: const Icon(Icons.add),
      ),
    );
  }

}