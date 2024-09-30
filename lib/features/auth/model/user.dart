import 'dart:convert';

import 'package:zenith/features/auth/model/user_details.dart';

class UserModel {
  final String id;
  final UserDetails userDetails;
  final String expeditionId;
  final String? lastQuizPlayedId;
  final List<String>? expeditionsIds;
  final List<String>? favExpeditions;
  final List<String>? quizesPlayed;
  final List<String>? quizesInProgress;
  final List<String>? expeditionsInProgress;
  final List<String>? badgesEarned;

  UserModel({
    required this.userDetails,
    required this.expeditionId,
    required this.id,
    this.badgesEarned,
    this.favExpeditions,
    this.expeditionsIds,
    this.expeditionsInProgress,
    this.lastQuizPlayedId,
    this.quizesInProgress,
    this.quizesPlayed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userDetails': userDetails.toMap(),
      'expeditionId': expeditionId,
      'lastQuizPlayedId': lastQuizPlayedId,
      'expeditionsIds': expeditionsIds,
      'favExpeditions': favExpeditions,
      'quizesPlayed': quizesPlayed,
      'quizesInProgress': quizesInProgress,
      'expeditionsInProgress': expeditionsInProgress,
      'badgesEarned': badgesEarned,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      userDetails: UserDetails.fromMap(map['userDetails']),
      expeditionId: map['expeditionId'] ?? '',
      lastQuizPlayedId: map['lastQuizPlayedId'],
      expeditionsIds: List<String>.from(map['expeditionsIds']),
      favExpeditions: List<String>.from(map['favExpeditions']),
      quizesPlayed: List<String>.from(map['quizesPlayed']),
      quizesInProgress: List<String>.from(map['quizesInProgress']),
      expeditionsInProgress: List<String>.from(map['expeditionsInProgress']),
      badgesEarned: List<String>.from(map['badgesEarned']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
