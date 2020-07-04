class IndicationModel {
  String idGejala, namaGejala, keterangan, gambar;

  IndicationModel({this.idGejala, this.namaGejala, this.keterangan, this.gambar});

  IndicationModel.fromJson(Map<String, dynamic> json) {
    idGejala= json['idgejala'];
    namaGejala = json['nama_gejala'];
    keterangan = json['keterangan'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idgejala'] = this.idGejala;
    data['nama_gejala'] = this.namaGejala;
    data['keterangan'] = this.keterangan;
    data['gambar'] = this.gambar;
    return data;
  }
}