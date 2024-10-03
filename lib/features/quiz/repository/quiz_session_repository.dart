import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/quiz/model/quiz_session.dart';

class QuizSessionRepository {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref('quiz_sessions/');

  FutureEither0 createQuizSession(QuizSession session) async {
    try {
      // Create a new entry with a unique ID
      final newSessionRef = _databaseRef.push();
      await newSessionRef.set(session.toMap());
      return success("Quiz session created successfully");
    } catch (e) {
      return failure("Failed to create quiz session: $e");
    }
  }

  FutureEither1<QuizSession> getQuizSession(String sessionId) async {
    try {
      // Fetch the snapshot for the specific sessionId
      final snapshot = await _databaseRef.child(sessionId).once();

      // Check if the snapshot contains data
      if (snapshot.snapshot.value != null) {
        final session = QuizSession.fromMap(
            snapshot.snapshot.value as Map<String, dynamic>);
        return Right(session);
      } else {
        return failure("Quiz session not found");
      }
    } catch (e) {
      return failure("Failed to read quiz session: $e");
    }
  }

  FutureEither0 updateQuizSession(String sessionId, QuizSession session) async {
    try {
      await _databaseRef.child(sessionId).update(session.toMap());
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
