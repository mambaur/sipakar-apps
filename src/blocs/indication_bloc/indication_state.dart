part of 'indication_bloc.dart';

@immutable
abstract class IndicationState {}

class IndicationInitial extends IndicationState {}

class IndicationWaiting extends IndicationState {}

class IndicationDetailWaiting extends IndicationState {}

class IndicationGetAll extends IndicationState {
  final List<IndicationModel> data;
  IndicationGetAll({this.data});
}

class IndicationById extends IndicationState{
  final IndicationModel data;
  IndicationById({this.data});
}

class IndicationError extends IndicationState {
  final String errorMessage;
  IndicationError({this.errorMessage});
}