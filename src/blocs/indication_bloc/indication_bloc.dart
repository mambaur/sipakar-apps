import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipakar_apps/src/models/identification.dart';
import 'package:sipakar_apps/src/models/indication.dart';
import 'package:sipakar_apps/src/repositories/identification_repository.dart';
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
    if (event is GetIndication) {
      yield* _getListIndication();
    }
    if (event is GetIndicationById) {
      yield* _getIndicationById(event.idgejala);
    }
    if (event is GetIdentificationResult) {
      yield* _getIdentificationResult(event.identificationModel);
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
      yield IndicationError(errorMessage: e.toString());
    }
  }

  Stream<IndicationState> _getIdentificationResult(
      IdentificationModel request) async* {
    IdentificationRepository _identificationRepository =
        IdentificationRepository();

    yield IndicationWaiting();
    try {
      var data = await _identificationRepository.postIdentification(request);
      var gejala1 = data['hasil'][0]['status'];
      var gejala2 = data['hasil'][1]['status'];
      var gejala3 = data['hasil'][2]['status'];
      var gejala4 = data['hasil'][3]['status'];
      if (gejala1 == 0 && gejala2 == 0 && gejala3 == 0 && gejala4 == 0) {
        yield IdentificationResultFalse(message: data['hasil']);
      } else {
        yield IdentificationResult(result: data['hasil']);
      }
    } catch (e) {
      yield IdentificationError(errorMessage: e.toString());
    }
  }
}
