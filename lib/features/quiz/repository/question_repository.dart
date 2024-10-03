import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:zenith/core/exceptions/exceptions.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/quiz/model/question.dart';
import 'package:zenith/features/quiz/model/quiz.dart';

class QuestionRepository {
  final firestore = FirebaseFirestore.instance;
  CollectionReference questionRef(String id) {
    return FirebaseFirestore.instance
        .collection("quiz")
        .doc(id)
        .collection("questions");
  }

  FutureEither0 addQuestion(
      {required Question question,
      required String? adminId,
      required String quizId}) async {
    try {
      if (adminId != null) {
        await questionRef(quizId)
            .doc(question.id)
            .set(question.toMap())
            .catchError((error) => throw error.toString());

        return Right(Success(message: "Question added successfully"));
      } else {
        return Left(Failure(message: "Owner Id is empty "));
      }
    } on FirebaseException catch (e) {
      return failure(e.toString());
    } catch (e, stackTrace) {
      debugPrint("error : $e \n StackTrace : $stackTrace ");
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither0 deleteQuestion(String quizId, String questionId) async {
    try {
      await questionRef(quizId).doc(questionId).delete();
      return Right(Success(message: "Question deleted successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither1<Question> getQuestionById(
      String quizId, String questionId) async {
    try {
      DocumentSnapshot docSnapshot =
          await questionRef(quizId).doc(questionId).get();
      if (docSnapshot.exists) {
        Question question =
            Question.fromMap(docSnapshot.data() as Map<String, dynamic>);
        print(question.toMap());
        return Right(
            Question.fromMap(docSnapshot.data() as Map<String, dynamic>));
      } else {
        return Left(Failure(message: "Question Doesnot exist"));
      }
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither0 updateQuestionById(String quizId, String questionId,
      Map<String, dynamic> updatefields) async {
    try {
      await questionRef(quizId)
          .doc(quizId)
          .update(updatefields)
          .catchError((error) => throw error.toString());

      return Right(Success(message: "Question updated successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Stream<List<Question>> getAllQuestions(String quizId) {
    try {
      return questionRef(quizId).snapshots().map((querySnapshot) =>
          querySnapshot.docs
              .map((documentSnapshot) => Question.fromMap(
                  documentSnapshot.data() as Map<String, dynamic>))
              .toList());
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e, stackTrace) {
      debugPrint(" error : ${e.toString()} \n stackTrace : $stackTrace");
      rethrow;
    }
  }

  // FutureEither1<List<Bill>> getAllHouseBills(String expeditionsIds) async {
  //   try {
  //     QuerySnapshot docs =
  //         await houseCollection.doc(expeditionsIds).collection("bills").get();
  //     return Right(docs.docs
  //         .map((docSnapshot) =>
  //             Bill.fromMap(docSnapshot.data() as Map<String, dynamic>))
  //         .toList());
  //   } on FirebaseException catch (e) {
  //     throw e.message.toString();
  //   } catch (e) {
  //     return Left(Failure(message: e.toString()));
  //   }
  // }
}
