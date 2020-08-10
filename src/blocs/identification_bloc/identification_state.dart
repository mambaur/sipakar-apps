part of 'identification_bloc.dart';

@immutable
abstract class IdentificationState {}

class IdentificationInitial extends IdentificationState {}

// class IdentificationWaiting extends IdentificationState {}


// class IdentificationResult extends IdentificationState{
//   final List<dynamic> result;
//   IdentificationResult({this.result});
// }

// class IdentificationError extends IdentificationState {
//   final String errorMessage;
//   IdentificationError({this.errorMessage});
// }