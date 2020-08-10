import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipakar_apps/src/models/identification.dart';
import 'package:sipakar_apps/src/repositories/identification_repository.dart';

part 'identification_event.dart';
part 'identification_state.dart';

class IdentificationBloc extends Bloc<IdentificationEvent, IdentificationState> {
  @override
   IdentificationState get initialState =>  IdentificationInitial();

  @override
  Stream<IdentificationState> mapEventToState(
    IdentificationEvent event,
  ) async* {
    // if (event is GetIdentificationResult){
    //   yield* _getIdentificationResult(event.identificationModel);
    // }
  }

  // Stream<IdentificationState> _getIdentificationResult(IdentificationModel request) async* {
  //   IdentificationRepository _identificationRepository = IdentificationRepository();

  //   yield IdentificationWaiting();
  //   try {
  //     var data = await _identificationRepository.postIdentification(request);
  //     // print(data['hasil'][0]['status']);
  //     yield IdentificationResult(result: data['hasil']);
  //   } catch (e) {
  //     yield  IdentificationError(errorMessage: e.toString());
  //   }
  // }
}
