part of 'indication_bloc.dart';

@immutable
abstract class IndicationEvent {}

class GetIndication extends IndicationEvent{}

class GetIndicationById extends IndicationEvent{
  final String idgejala;
  GetIndicationById({this.idgejala});
}

class GetIdentificationResult extends GetIndication{
  final IdentificationModel identificationModel;
  GetIdentificationResult({this.identificationModel});
}