part of 'disease_bloc.dart';

@immutable
abstract class DiseaseState {}

class DiseaseInitial extends DiseaseState {}

class DiseaseLoaded extends DiseaseState{
  final List<Disease> listDisease;
  DiseaseLoaded({this.listDisease});
}

class DiseaseDetailWaiting extends DiseaseState {}

class DiseaseById extends DiseaseState{
  final Disease data;
  DiseaseById({this.data});
}

class DiseaseError extends DiseaseState{
  final String errorMessage;
  DiseaseError({this.errorMessage});
}

class DiseaseWaiting extends DiseaseState{}