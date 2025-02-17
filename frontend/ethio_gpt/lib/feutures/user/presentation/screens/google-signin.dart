import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  clientId: (defaultTargetPlatform == TargetPlatform.android)
      ? "199108539875-eriel7b0ph51gl2pk79dvs6sf720dlsm.apps.googleusercontent.com"
      : "199108539875-eriel7b0ph51gl2pk79dvs6sf720dlsm.apps.googleusercontent.com",
);

Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return; // User canceled sign-in

    final String userEmail = googleUser.email;

    log('email is');
    log(userEmail);
  } catch (error) {
    log("Error signing in with Google: $error");
  }
}
