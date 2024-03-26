import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/auth_response.dart';
import '../../model/user_model.dart';
import '../helper/debug_print.dart';

class AuthService {
  AuthService._private();

  static AuthService authService = AuthService._private();

  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future<AuthResponse> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user!;
      return AuthResponse(user: user);
    } on FirebaseAuthException catch (e) {
      kprint('fire base login error');
      kprint(e.toString());
      return AuthResponse(error: e.message.toString());
    }
  }

  Future<AuthResponse> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user!;
      return AuthResponse(user: user);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(error: e.message.toString());
    }
  }

  Future<AuthResponse> signInWithGoogle() async {
    try {
      final gAccount = await googleSignIn.signIn();
      final authentication = await gAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      final result = await auth.signInWithCredential(credential);
      final user = result.user!;

      return AuthResponse(user: user);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(error: e.message.toString());
    }
  }

  Future<void> signOut(bool? isGoogleLogin) async {
    await auth.signOut();
    if (isGoogleLogin == true) {
      await googleSignIn.disconnect();
    }
  }
}
