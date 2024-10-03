import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:zenith/core/exceptions/exceptions.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/quiz/model/quiz.dart';

class QuizRepository {
  final firestore = FirebaseFirestore.instance;
  final quizCollection = FirebaseFirestore.instance.collection("quiz");

  FutureEither0 addQuiz({required Quiz quiz, required String? adminId}) async {
    try {
      if (adminId != null) {
        await quizCollection
            .doc(quiz.id)
            .set(quiz.toMap())
            .catchError((error) => throw error.toString());

        return Right(Success(message: "Quiz added successfully"));
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

  FutureEither0 deleteQuiz(String expeditionId) async {
    try {
      await firestore.doc(expeditionId).delete();
      return Right(Success(message: "Quiz deleted successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither1<Quiz> getQuizById(String quizId) async {
    try {
      DocumentSnapshot docSnapshot = await quizCollection.doc(quizId).get();
      if (docSnapshot.exists) {
        Quiz h = Quiz.fromMap(docSnapshot.data() as Map<String, dynamic>);
        print(h.toMap());
        return Right(Quiz.fromMap(docSnapshot.data() as Map<String, dynamic>));
      } else {
        return Left(Failure(message: "Quiz Doesnot exist"));
      }
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Quiz> getQuizByExpeditionId(String expeditionId) async {
    try {
      // Querying the quiz collection where the expeditionId matches the provided value
      QuerySnapshot querySnapshot = await quizCollection
          .where('expeditionId', isEqualTo: expeditionId)
          .limit(
              1) // Limit to 1 result if you expect only one quiz per expedition
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming the first document in the list is the result
        DocumentSnapshot docSnapshot = querySnapshot.docs.first;

        Quiz quiz = Quiz.fromMap(docSnapshot.data() as Map<String, dynamic>);
        print(quiz.toMap());

        return quiz;
      } else {
        throw Exception("Quiz does not exist for the provided expeditionId");
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error fetching quiz: $e");
    }
  }

  FutureEither0 updateQuizId(
      String quizId, Map<String, dynamic> updatefields) async {
    try {
      await quizCollection
          .doc(quizId)
          .update(updatefields)
          .catchError((error) => throw error.toString());

      return Right(Success(message: "Quiz updated successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither1<List<Quiz>> getUserFavQuizes(List<dynamic> quizIds) async {
    try {
      List<Quiz> list = [];
      for (var id in quizIds) {
        DocumentSnapshot docs = await quizCollection
            .doc(id)
            .get()
            .catchError((error) => throw error.toString());
        print(docs.data() as Map<String, dynamic>);
        list.add(Quiz.fromMap(docs.data() as Map<String, dynamic>));
      }
      return Right(list);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e, stackTrace) {
      debugPrint(" error : ${e.toString()} \n stackTrace : $stackTrace");
      return Left(Failure(message: e.toString()));
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

  Stream<List<Quiz>> getAllQuizes() {
    try {
      (quizCollection.snapshots().map((querySnapshot) => querySnapshot.docs
          .map((documentSnapshot) => print(documentSnapshot.data()))
          .toList()));
      return quizCollection.snapshots().map((querySnapshot) => querySnapshot
          .docs
          .map((documentSnapshot) => Quiz.fromMap(documentSnapshot.data()))
          .toList());
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e, stackTrace) {
      debugPrint(" error : ${e.toString()} \n stackTrace : $stackTrace");
      rethrow;
    }
  }

  // Stream<List<Quiz>> getAllRentalHouse() {
  //   try {
  //     return expeditionCollection
  //         .where("houseStatus", isEqualTo: HouseStatus.Rent.toString())
  //         .snapshots()
  //         .map((querySnapshot) => querySnapshot.docs
  //             .map((documentSnapshot) =>
  //                 Quiz.fromMap(documentSnapshot.data()))
  //             .toList());
  //   } on FirebaseException catch (e) {
  //     throw e.message.toString();
  //   } catch (e, stackTrace) {
  //     debugPrint(" error : ${e.toString()} \n stackTrace : $stackTrace");
  //     rethrow;
  //   }
  // }
}
