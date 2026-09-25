import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/learning_goal.dart';
import 'learning_goal_service.dart';

class FirebaseLearningGoalService implements LearningGoalService {
  final FirebaseFirestore firestore;

  FirebaseLearningGoalService(this.firestore);

  @override
  Future<List<LearningGoal>> getLearningGoals() async {
    final result = await firestore
        .collection('learning_goals')
        .get();

    return result.docs.map((doc) {
      final data = doc.data();

      return LearningGoal(
        data['title'],
        data['completed'],
      );
    }).toList();
  }

  @override
  Future<void> addLearningGoal(String title) async {
    await firestore.collection('learning_goals').add({
      'title': title,
      'completed': false,
    });
  }

  @override
  Future<void> updateLearningGoal(
      String title,
      bool completed,
      ) async {
    final result = await firestore
        .collection('learning_goals')
        .where('title', isEqualTo: title)
        .get();

    for (final doc in result.docs) {
      await doc.reference.update({
        'completed': completed,
      });
    }
  }

  @override
  Future<void> deleteLearningGoal(String title) async {
    final result = await firestore
        .collection('learning_goals')
        .where('title', isEqualTo: title)
        .get();

    for (final doc in result.docs) {
      await doc.reference.delete();
    }
  }
}