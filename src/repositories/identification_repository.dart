import 'dart:convert';
import 'package:sipakar_apps/src/models/identification.dart';
import 'package:http/http.dart' as http;

class IdentificationRepository {
  Future postIdentification(IdentificationModel identificationModel) async{
    try {
      http.Response response = await http.post('http://192.168.43.206/skripsi/api/identification/', body:identificationModel.toJson());
      var dataResponse = json.decode(response.body);
      // print(dataResponse);
      return dataResponse;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}