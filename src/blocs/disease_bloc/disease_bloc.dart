import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipakar_apps/src/models/disease.dart';
import 'package:sipakar_apps/src/repositories/disease_repository.dart';

part 'disease_event.dart';
part 'disease_state.dart';

class DiseaseBloc extends Bloc<DiseaseEvent, DiseaseState> {
  @override
  DiseaseState get initialState => DiseaseInitial();

  @override
  Stream<DiseaseState> mapEventToState(
    DiseaseEvent event,
  ) async* {
    if (event is GetListDisease){
      yield* _getListDisease();
    }
    if (event is GetDiseaseById){
      yield* _getIndicationById(event.idpenyakit);
    }
  }

  Stream<DiseaseState> _getListDisease() async* {
    DiseaseRepository _diseaseRepository = DiseaseRepository();

    yield DiseaseWaiting();
    try {
      List<Disease> data = await _diseaseRepository.getDisease();
      yield DiseaseLoaded(listDisease: data);
    } catch (e) {
      yield DiseaseError(errorMessage: e.toString());
    }
  }

  Stream<DiseaseState> _getIndicationById(String request) async* {
    DiseaseRepository _diseaseRepository = DiseaseRepository();

    yield DiseaseDetailWaiting();
    try {
      Disease data = await _diseaseRepository.getDataById(request);
      yield DiseaseById(data: data);
    } catch (e) {
      yield  DiseaseError(errorMessage: e.toString());
    }
  }
}
