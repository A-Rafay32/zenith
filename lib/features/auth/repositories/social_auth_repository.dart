import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zenith/core/exceptions/exceptions.dart';
import 'package:zenith/features/auth/model/user_details.dart';
import 'package:zenith/features/auth/repositories/auth_repository.dart';
import 'package:zenith/features/auth/model/user.dart';
import 'package:zenith/features/auth/repositories/user_repository.dart';

class SocialAuthService extends AuthRepository {
  Future<Either<Failure, Success>> googleSignIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //check for exisiting user
      if (googleUser != null) {
        final foundUser =
            await UserRepository().getUserByEmail(googleUser.email);
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // if failed to get any user with this email
        if (foundUser.isLeft) {
          final result = await UserRepository().createUser(
              user: UserModel(
                  expeditionId:
                      "${userCredential.user?.displayName}-${Random().nextInt(100)}",
                  id: userCredential.user?.uid ?? "",
                  userDetails: UserDetails(
                      name: userCredential.user?.displayName ?? "",
                      email: userCredential.user?.email ?? "",
                      password: "")),
              uid: userCredential.user?.uid.toString() ?? "");
        }
      }
      return Right(
          Success(message: "User signed in with {credential.signInMethod}"));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message.toString()));
    }
  }

  Future<Either<Failure, Success>> facebookSignIn() async {
    try {
      return Right(
          Success(message: "User signed in with {credential.signInMethod}"));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message.toString()));
    }
  }

  // void googleSignIn() {
  //   try {} catch (e) {
  //     rethrow;
  //   }
  // }

  void twitterSignUp() {
    try {} catch (e) {
      rethrow;
    }
  }

  void twitterSignIn() {
    try {} catch (e) {
      rethrow;
    }
  }
}
