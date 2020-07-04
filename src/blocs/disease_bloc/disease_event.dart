part of 'disease_bloc.dart';

@immutable
abstract class DiseaseEvent {}

class GetListDisease extends DiseaseEvent{}

class GetDiseaseById extends DiseaseEvent{
  final String idpenyakit;
  GetDiseaseById({this.idpenyakit});
}