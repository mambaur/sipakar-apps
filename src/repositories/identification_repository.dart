import 'dart:convert';
import 'package:sipakar_apps/src/models/identification.dart';
import 'package:http/http.dart' as http;

class IdentificationRepository {
  Future postIdentification(IdentificationModel identificationModel) async {
    try {
      // http.Response response = await http.post('http://sipakartembakau.000webhostapp.com/api/identification/', body:identificationModel.toJson());
      http.Response response = await http.post(
          'https://sipakar.caraguna.com/api/identification/',
          body: identificationModel.toJson());
      var dataResponse = json.decode(response.body);
      // print(dataResponse);
      return dataResponse;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
