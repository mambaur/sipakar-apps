import 'dart:convert';

import 'package:sipakar_apps/src/models/disease.dart';
import 'package:http/http.dart' as http;

class DiseaseRepository {
  Future<List<Disease>> getDisease() async {
    try {
      http.Response response =
          await http.get('http://192.168.43.206/skripsi/api/disease');
      List listResponse = json.decode(response.body) as List;
      List<Disease> listDisease =
          listResponse.map((f) => Disease.fromJson(f)).toList();
      return listDisease;
    } catch (e) {
      throw Exception(e);
      // print(e);
    }
  }

  Future getDataById(String idpenyakit) async {
    try {
      http.Response response = await http.post(
          'http://192.168.43.206/skripsi/api/disease/getById',
          body: {'idpenyakit': idpenyakit});
      var dataResponse = json.decode(response.body);
      Disease data = Disease.fromJson(dataResponse);
      return data;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
