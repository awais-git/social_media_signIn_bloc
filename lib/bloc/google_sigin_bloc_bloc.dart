import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'google_sigin_bloc_state.dart';

class GoogleSiginCubit extends Cubit<GoogleSiginBlocState> {
  GoogleSiginCubit() : super(GoogleSiginBlocInitialState());

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future googleSigin() async {
     emit(GoogleSiginLoadingState());
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
       
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final User? user =
            (await firebaseAuth.signInWithCredential(authCredential)).user;

        log('These are details of the user :${user!.displayName.toString()} \n ${user.email} \n ${user.photoURL} ');

        emit(GoogleSiginBlocSuccessfulState());
      } on FirebaseAuthException catch (e) {
        emit(GoogleSigninBlocUnsuccessfulState(errorMessage: e.toString()));
      }
    }
  }
}
