import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/quiz/model/quiz_session.dart';

class QuizSessionRepository {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref("quiz_sessions");

  FutureEither0 createQuizSession(QuizSession session) async {
    try {
      await _databaseRef.child(session.id).set(session.toMap());
      return success("Quiz session created successfully");
    } catch (e) {
      return failure("Failed to create quiz session: $e");
    }
  }

  Future<QuizSession> getQuizSession(String sessionId) async {
    try {
      // Fetch the snapshot for the specific sessionId
      print(sessionId);
      final snapshot = await _databaseRef.child(sessionId).get();

      // Check if the snapshot contains data
      if (snapshot.exists && snapshot.value != null) {
        final session =
            QuizSession.fromMap(snapshot.value as Map<String, dynamic>);
        print(session.toMap());
        return session;
      } else {
        // If the session doesn't exist, handle it gracefully
        debugPrint("No quiz session found for sessionId: $sessionId");
        throw "No quiz session found";
      }
    } on FirebaseException catch (e) {
      debugPrint("Failed to read quiz session: $e");
      throw "Failed to read quiz session: $e";
    }
  }

  FutureEither0 updateQuizSession(
      String sessionId, Map<String, dynamic> session) async {
    try {
      await _databaseRef.child(sessionId).update(session);
      return success("Quiz session updated successfully");
    } catch (e) {
      return failure("Failed to update quiz session: $e");
    }
  }

  FutureEither0 deleteQuizSession(String sessionId) async {
    try {
      await _databaseRef.child(sessionId).remove();
      return success("Quiz session deleted successfully");
    } catch (e) {
      return failure("Failed to delete quiz session: $e");
    }
  }
}
