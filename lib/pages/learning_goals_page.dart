import 'package:flutter/material.dart';
import 'package:dev_shepherd/models/learning_goal.dart';
import 'package:dev_shepherd/data/learning_goal_data.dart';
import 'package:dev_shepherd/services/learning_goal_service.dart';


class LearningGoalsPage extends StatefulWidget {
  final bool loadFromFirebase;
  final LearningGoalService learningGoalService;

  const LearningGoalsPage({
    super.key,
    this.loadFromFirebase = true,
    required this.learningGoalService,
  });

  @override
  State<LearningGoalsPage> createState() => _LearningGoalsPageState();
}
class _LearningGoalsPageState extends State<LearningGoalsPage> {

  @override
  void initState() {
    super.initState();

    if (widget.loadFromFirebase) {
      docsToLearningGoals();
    }
  }
  void _addLearningGoal(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add learning goal"),
              content: TextField(
                controller: textEditingController,
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (textEditingController.text.trim().isEmpty) {
                      return;
                    }
                    try {
                      print("ADD BUTTON PRESSED");

                      await widget.learningGoalService.addLearningGoal(
                        textEditingController.text,
                      );

                      await docsToLearningGoals();

                      print("FIREBASE WRITE SUCCESS");

                      Navigator.pop(context);

                      print("DIALOG SHOULD BE CLOSED");
                    } catch (e) {
                      print("FIREBASE ERROR: $e");
                    }
                  },
                  child: const Text("Add"),
                ),
                TextButton(onPressed: () {
                  Navigator.pop(context);  // closes the dialog
                }, child: Text("Cancel")),
              ]
          );
        });
  }
  Future<void> docsToLearningGoals() async {
    final goals = await widget.learningGoalService.getLearningGoals();

    learningGoals.clear();
    learningGoals.addAll(goals);

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Goals Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          const Text('Learning Goals',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              )),
          if (learningGoals.isEmpty)
            const Text("No learning goals. Tap + to add a learning goal.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold
            ),),

            SizedBox(height: 16,),

          Card(
            child: Padding(padding: const EdgeInsets.all(16),
              child: Column(
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16,),

                Text('$completedGoals / $totalGoals goals completed'),

                LinearProgressIndicator(
                    value: progress,
                    backgroundColor:
                    Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green,)),
                ],
          ) ,),),

          ExpansionTile(
              title: const Text("Active Goals",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              children: [

                if (!learningGoals.any((goal) => !goal.isCompleted))
                  const Text('No active goals.'),
                for (LearningGoal goal in learningGoals)
                  if (!goal.isCompleted)
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
              ]),


          ExpansionTile(
              title: const Text("Completed Goals",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              children: [
                if (!learningGoals.any((goal) => goal.isCompleted))
                  const Text('No completed goals'),
                for (LearningGoal goal in learningGoals)
                  if (goal.isCompleted)
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
                  ),],)

        ],
        ),
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