import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sipakar_apps/src/models/indication.dart';

class IndicationRepository {
  Future<List<IndicationModel>> getIndication() async {
    try {
      http.Response response =
          await http.get('http://192.168.43.206/skripsi/api/indication');
      List listResponse = json.decode(response.body) as List;
      List<IndicationModel> listDisease =
          listResponse.map((f) => IndicationModel.fromJson(f)).toList();
      return listDisease;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getDataById(String idgejala) async {
    try {
      http.Response response = await http.post(
          'http://192.168.43.206/skripsi/api/indication/getById',
          body: {'idgejala': idgejala});
      var dataResponse = json.decode(response.body);
      IndicationModel data = IndicationModel.fromJson(dataResponse);
      return data;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
