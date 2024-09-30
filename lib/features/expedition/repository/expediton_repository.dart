import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:zenith/core/exceptions/exceptions.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/expedition/model/expedition.dart';

class ExpeditionRepository {
  final firestore = FirebaseFirestore.instance;
  final expeditionCollection =
      FirebaseFirestore.instance.collection("expeditions");

  FutureEither0 addExpedition(
      {required Expedition expedition, required String? adminId}) async {
    try {
      if (adminId != null) {
        await expeditionCollection
            .add(expedition.toMap())
            .catchError((error) => throw error.toString());

        return Right(Success(message: "Expedition added successfully"));
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

  FutureEither0 deleteExpedition(String expeditionId) async {
    try {
      await firestore.doc(expeditionId).delete();
      return Right(Success(message: "Expedition deleted successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither1<Expedition> getExpeditionById(String expeditionId) async {
    try {
      DocumentSnapshot docSnapshot =
          await expeditionCollection.doc(expeditionId).get();
      if (docSnapshot.exists) {
        Expedition h =
            Expedition.fromMap(docSnapshot.data() as Map<String, dynamic>);
        print(h.toMap());
        return Right(
            Expedition.fromMap(docSnapshot.data() as Map<String, dynamic>));
      } else {
        return Left(Failure(message: "Expedition Doesnot exist"));
      }
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither0 updateExpeditionById(
      String expeditionId, Map<String, dynamic> updatefields) async {
    try {
      await expeditionCollection
          .doc(expeditionId)
          .update(updatefields)
          .catchError((error) => throw error.toString());

      return Right(Success(message: "Expedition updated successfully"));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  FutureEither1<List<Expedition>> getUserFavExpeditions(
      List<dynamic> expeditionsIds) async {
    try {
      List<Expedition> list = [];
      for (var id in expeditionsIds) {
        DocumentSnapshot docs = await expeditionCollection
            .doc(id)
            .get()
            .catchError((error) => throw error.toString());
        print(docs.data() as Map<String, dynamic>);
        list.add(Expedition.fromMap(docs.data() as Map<String, dynamic>));
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

  Stream<List<Expedition>> getAllExpeditions() {
    try {
      return expeditionCollection.snapshots().map((querySnapshot) =>
          querySnapshot.docs
              .map((documentSnapshot) =>
                  Expedition.fromMap(documentSnapshot.data()))
              .toList());
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e, stackTrace) {
      debugPrint(" error : ${e.toString()} \n stackTrace : $stackTrace");
      rethrow;
    }
  }

  // Stream<List<Expedition>> getAllRentalHouse() {
  //   try {
  //     return expeditionCollection
  //         .where("houseStatus", isEqualTo: HouseStatus.Rent.toString())
  //         .snapshots()
  //         .map((querySnapshot) => querySnapshot.docs
  //             .map((documentSnapshot) =>
  //                 Expedition.fromMap(documentSnapshot.data()))
  //             .toList());
  //   } on FirebaseException catch (e) {
  //     throw e.message.toString();
  //   } catch (e, stackTrace) {
  //     debugPrint(" error : ${e.toString()} \n stackTrace : $stackTrace");
  //     rethrow;
  //   }
  // }
}
