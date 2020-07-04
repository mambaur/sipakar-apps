import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipakar_apps/src/models/indication.dart';
import 'package:sipakar_apps/src/repositories/indication_repository.dart';

part 'indication_event.dart';
part 'indication_state.dart';

class IndicationBloc extends Bloc<IndicationEvent, IndicationState> {
  @override
  IndicationState get initialState => IndicationInitial();

  @override
  Stream<IndicationState> mapEventToState(
    IndicationEvent event,
  ) async* {
    if (event is GetIndication){
      yield* _getListIndication();
    }
    if (event is GetIndicationById){
      yield* _getIndicationById(event.idgejala);
    }
  }

  Stream<IndicationState> _getListIndication() async* {
    IndicationRepository _indicationRepository = IndicationRepository();

    yield IndicationWaiting();
    try {
      List<IndicationModel> data = await _indicationRepository.getIndication();
      yield IndicationGetAll(data: data);
    } catch (e) {
      yield IndicationError(errorMessage: e.toString());
    }
  }

  Stream<IndicationState> _getIndicationById(String request) async* {
    IndicationRepository _indicationRepository = IndicationRepository();

    yield IndicationDetailWaiting();
    try {
      IndicationModel data = await _indicationRepository.getDataById(request);
      yield IndicationById(data: data);
    } catch (e) {
      yield  IndicationError(errorMessage: e.toString());
    }
  }
}
