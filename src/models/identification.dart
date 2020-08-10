
class IdentificationModel {
  String email;
  String gejala1;
  String gejala2;
  String gejala3;
  String gejala4;
  String gejala5;
  String gejala6;
  String gejala7;
  String gejala8;
  String gejala9;
  String gejala10;
  String gejala11;
  String gejala12;
  String gejala13;
  String gejala14;
  String gejala15;
  String gejala16;
  String gejala17;

  IdentificationModel({this.email, this.gejala1, this.gejala2, this.gejala3, this.gejala4, this.gejala5, this.gejala6, this.gejala7, this.gejala8, this.gejala9, this.gejala10, this.gejala11, this.gejala12, this.gejala13, this.gejala14, this.gejala15, this.gejala16, this.gejala17});

  IdentificationModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    gejala1 = json['gejala1'];
    gejala2 = json['gejala2'];
    gejala3 = json['gejala3'];
    gejala4 = json['gejala4'];
    gejala5 = json['gejala5'];
    gejala6 = json['gejala6'];
    gejala7 = json['gejala7'];
    gejala8 = json['gejala8'];
    gejala9 = json['gejala9'];
    gejala10 = json['gejala10'];
    gejala11 = json['gejala11'];
    gejala12 = json['gejala12'];
    gejala13 = json['gejala13'];
    gejala14 = json['gejala14'];
    gejala15 = json['gejala15'];
    gejala16 = json['gejala16'];
    gejala17 = json['gejala17'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['gejala1'] = this.gejala1;
    data['gejala2'] = this.gejala2;
    data['gejala3'] = this.gejala3;
    data['gejala4'] = this.gejala4;
    data['gejala5'] = this.gejala5;
    data['gejala6'] = this.gejala6;
    data['gejala7'] = this.gejala7;
    data['gejala8'] = this.gejala8;
    data['gejala9'] = this.gejala9;
    data['gejala10'] = this.gejala10;
    data['gejala11'] = this.gejala11;
    data['gejala12'] = this.gejala12;
    data['gejala13'] = this.gejala13;
    data['gejala14'] = this.gejala14;
    data['gejala15'] = this.gejala15;
    data['gejala16'] = this.gejala16;
    data['gejala17'] = this.gejala17;
    return data;
  }
}
