import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:zenith/core/exceptions/exceptions.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/expedition/model/expedition.dart';
import 'package:zenith/features/expedition/model/expedtion_detail.dart';

class ExpeditionDetailRepository {
  final firestore = FirebaseFirestore.instance;

  CollectionReference detailsRef(String id) {
    return FirebaseFirestore.instance
        .collection("expeditions")
        .doc(id)
        .collection("expeditionDetails");
  }

  FutureEither0 addExpeditionDetail(
      {required ExpeditionDetail expeditionDetail,
      required String? adminId,
      required String expeditionId}) async {
    try {
      if (adminId != null) {
        await detailsRef(expeditionId)
            .doc(expeditionDetail.id)
            .set(expeditionDetail.toMap())
            .catchError((error) => throw error.toString());

        return Right(Success(message: "Expedition Details added successfully"));
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

  FutureEither0 deleteExpeditionDetail(
      String expeditionId, String expeditionDetailId) async {
    try {
      await detailsRef(expeditionId).doc(expeditionDetailId).delete();
      return Right(Success(message: "Expedition Details deleted successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither1<ExpeditionDetail> getExpeditionDetailById(
      String expeditionId, String expeditionDetailId) async {
    try {
      DocumentSnapshot docSnapshot =
          await detailsRef(expeditionId).doc(expeditionDetailId).get();
      if (docSnapshot.exists) {
        ExpeditionDetail expeditionDetail = ExpeditionDetail.fromMap(
            docSnapshot.data() as Map<String, dynamic>);
        print(expeditionDetail.toMap());
        return Right(ExpeditionDetail.fromMap(
            docSnapshot.data() as Map<String, dynamic>));
      } else {
        return Left(Failure(message: "Expedition Details Doesnot exist"));
      }
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither0 updateExpeditionDetailById(String expeditionId,
      String expeditionDetailId, Map<String, dynamic> updatefields) async {
    try {
      await detailsRef(expeditionId)
          .doc(expeditionId)
          .update(updatefields)
          .catchError((error) => throw error.toString());

      return Right(Success(message: "Expedition Details updated successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Stream<List<ExpeditionDetail>> getAllExpeditionDetails(String exceptionId) {
    try {
      return detailsRef(exceptionId).snapshots().map((querySnapshot) =>
          querySnapshot.docs
              .map((documentSnapshot) => ExpeditionDetail.fromMap(
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
