part of 'google_sigin_bloc_bloc.dart';

@immutable
abstract class GoogleSiginBlocState {}

class GoogleSiginBlocInitialState extends GoogleSiginBlocState {}

class GoogleSiginBlocSuccessfulState extends GoogleSiginBlocState {}

class GoogleSigninBlocUnsuccessfulState extends GoogleSiginBlocState {
  final String? errorMessage;
  GoogleSigninBlocUnsuccessfulState({this.errorMessage});
}

class GoogleSiginLoadingState extends GoogleSiginBlocState {}
