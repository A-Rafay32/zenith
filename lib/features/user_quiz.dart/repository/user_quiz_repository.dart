import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:zenith/core/exceptions/exceptions.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/user_quiz.dart/model/user_quiz.dart';

class UserQuizRepository {
  final firestore = FirebaseFirestore.instance;
  final userQuizCollection = FirebaseFirestore.instance.collection("userQuiz");

  FutureEither0 addUserQuiz(
      {required UserQuiz userQuiz, required String? adminId}) async {
    try {
      if (adminId != null) {
        await userQuizCollection
            .doc(userQuiz.id)
            .set(userQuiz.toMap())
            .catchError((error) => throw error.toString());

        return Right(Success(message: "UserQuiz added successfully"));
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

  FutureEither0 deleteUserQuiz(String userQuiz) async {
    try {
      await firestore.doc(userQuiz).delete();
      return Right(Success(message: "UserQuiz deleted successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither1<UserQuiz> getUserQuizById(String userQuizId) async {
    try {
      DocumentSnapshot docSnapshot =
          await userQuizCollection.doc(userQuizId).get();
      if (docSnapshot.exists) {
        UserQuiz h =
            UserQuiz.fromMap(docSnapshot.data() as Map<String, dynamic>);
        print(h.toMap());
        return Right(
            UserQuiz.fromMap(docSnapshot.data() as Map<String, dynamic>));
      } else {
        return Left(Failure(message: "UserQuiz Doesnot exist"));
      }
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither0 updateUserQuizId(
      String userQuizId, Map<String, dynamic> updatefields) async {
    try {
      await userQuizCollection
          .doc(userQuizId)
          .update(updatefields)
          .catchError((error) => throw error.toString());

      return Right(Success(message: "UserQuiz updated successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither1<List<UserQuiz>> getUserFavQuizes(List<dynamic> quizIds) async {
    try {
      List<UserQuiz> list = [];
      for (var id in quizIds) {
        DocumentSnapshot docs = await userQuizCollection
            .doc(id)
            .get()
            .catchError((error) => throw error.toString());
        print(docs.data() as Map<String, dynamic>);
        list.add(UserQuiz.fromMap(docs.data() as Map<String, dynamic>));
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

  Stream<List<UserQuiz>> getAllUserQuizes() {
    try {
      (userQuizCollection.snapshots().map((querySnapshot) => querySnapshot.docs
          .map((documentSnapshot) => print(documentSnapshot.data()))
          .toList()));
      return userQuizCollection.snapshots().map((querySnapshot) => querySnapshot
          .docs
          .map((documentSnapshot) => UserQuiz.fromMap(documentSnapshot.data()))
          .toList());
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e, stackTrace) {
      debugPrint(" error : ${e.toString()} \n stackTrace : $stackTrace");
      rethrow;
    }
  }

  // Stream<List<UserQuiz>> getAllRentalHouse() {
  //   try {
  //     return expeditionCollection
  //         .where("houseStatus", isEqualTo: HouseStatus.Rent.toString())
  //         .snapshots()
  //         .map((querySnapshot) => querySnapshot.docs
  //             .map((documentSnapshot) =>
  //                 UserQuiz.fromMap(documentSnapshot.data()))
  //             .toList());
  //   } on FirebaseException catch (e) {
  //     throw e.message.toString();
  //   } catch (e, stackTrace) {
  //     debugPrint(" error : ${e.toString()} \n stackTrace : $stackTrace");
  //     rethrow;
  //   }
  // }
}
