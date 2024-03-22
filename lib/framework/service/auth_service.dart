import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_fly/framework/model/user/auth_response.dart';
import 'package:food_fly/framework/service/fire_base_singleton.dart';
import 'package:food_fly/ui/utils/widgets/common_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/user/user_model.dart';

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
      final user = userCredential.user!;
      return AuthResponse(
          user: UserModel(
        uid: user.uid,
        email: user.email,
      ));
    } on FirebaseAuthException catch (e) {
      return AuthResponse(error: e.message.toString());
    }
  }

  Future<AuthResponse> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user!;
      return AuthResponse(user: UserModel(uid: user.uid, email: user.email));
    } on FirebaseAuthException catch (e) {
      return AuthResponse(error: e.message.toString());
    }
  }

  Future<AuthResponse> signInWithGoogle() async {
    try{
      final gAccount = await googleSignIn.signIn();
      final authentication = await gAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      final result = await auth.signInWithCredential(credential);
      final user = result.user!;

      return AuthResponse(
          user: UserModel(
              uid: user.uid,
              email: user.email,
              name: user.displayName,
              profileImage: user.photoURL));
    }on FirebaseAuthException catch(e){
      return AuthResponse(error: e.message.toString());
    }
  }

  Future<void> signOut(bool? isGoogleLogin)async{
     await auth.signOut();
     if(isGoogleLogin == true){
       await googleSignIn.disconnect();
     }
  }

  Future forgetPass({required String email}) async{
    try{
      await FirebaseSingleTon.firebaseSingleTon.firebaseAuth.sendPasswordResetEmail(email: email);
      commonToast("code hase been sent to your mail");
    }on FirebaseAuthException catch(e){
      Future.error(e.toString());
      commonToast("Something went wrong");
    }
  }

  Future deleteAcc()async{
    User? user = FirebaseSingleTon.firebaseSingleTon.firebaseAuth.currentUser;
    if(user != null){
      await user.delete();
    }
  }
}
