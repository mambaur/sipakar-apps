import 'package:flutter/material.dart';

class TobaccoScreen extends StatefulWidget {
  @override
  _TobaccoScreenState createState() => _TobaccoScreenState();
}

class _TobaccoScreenState extends State<TobaccoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.spa,
                  color: Colors.green,
                  size: 40,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Tembakau Kasturi',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.green)),
                      Text('Informasi tentang tembakau kasturi',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            height: 145,
                            color: Colors.grey[200],
                            child: Image(
                              image: AssetImage('assets/tembakau1.jpg'),
                              fit: BoxFit.cover,
                              // width: 300.0,
                            ),
                          ))),
                  Flexible(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Column(
                          children: <Widget>[
                            TitleTobacco(title: 'Nama', value: 'Tembakau Kasturi'),
                            TitleTobacco(title: 'Asal Varietas', value: 'Seleksi massa positif kasturi'),
                            TitleTobacco(title: 'Phylotaxi', value: '2/5, putar ke kiri'),
                            TitleTobacco(title: 'Indeks daun', value: '0,486'),
                            TitleTobacco(title: 'Jumlah daun', value: '16-18 lembar'),
                            TitleTobacco(title: 'Produksi', value: '1,75 ton kerosok/ha'),
                            TitleTobacco(title: 'Indeks mutu', value: '81,75 - 0,98'),
                            TitleTobacco(title: 'Kadar nikoton', value: '3,21 - 0,08'),
                          ],
                        ),
                      )),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Definisi Tembakau Kasturi :',
                    style: TextStyle(color: Colors.grey[400], fontSize: 10),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: 
                          Text(
                              "Tembakau kasturi adalah tembakau kerosok lokal VO sebagai bahan campuran (blending) untuk rokok keretek, yang dikembangkan di daerah Jember dan Bondowoso. Dari seluruh produksi nasional tembakau kasturi, 11,36% diekspor dengan label Besuki VO dan 88,64% dikonsumsi dalam negeri sebagai bahan baku rokok keretek."),
                       
                    ),
                  )
                ]),
          ),
          Container(
            child: SizedBox(
              height: 120,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ImageCard(imagePath: 'assets/tembakau2.jpg',),
                  ImageCard(imagePath: 'assets/tembakau4.jpg',),
                  ImageCard(imagePath: 'assets/tembakau5.jpg',),
                  ImageCard(imagePath: 'assets/tembakau6.jpg',),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Pabrik Rokok Gudang Garam, Sampoerna, dan Djarum merupakan pengguna terbesar kerosok kasturi. Semula yang ditanam oleh petani adalah varietas lokal berupa populasi tanaman yang masih sangat beragam. Sejak tahun 1997 dilakukan pemuliaan untuk memperbaiki varietas lokal yang ada. "),
                    ),
                  )
                ]),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5,),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Seleksi terhadap varietas lokal menghasilkan dua varietas yang diputihkan/dilepas pada tahun 2006, yaitu Kasturi 1 dan Kasturi 2 berdasarkan SK Mentan No: 132/Kpts/SR.120/2/ 2007 dan No: 133/Kpts/SR.120/2/2007. Saat ini luas areal penanaman tembakau kasturi pada dua daerah pengembangan mencapai 3.197 ha, dengan rata-rata produktivitas di tingkat petani mencapai 985 kg kerosok/ha atau senilai Rp12.805.000,00."),
                    ),
                  )
                ]),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        "Sumber referrensi: http://balittas.litbang.pertanian.go.id/index.php/id/tentang-kami/komoditas/pemanis/60-info-teknologi/104-kasturi", style: TextStyle(color: Colors.grey[300], fontSize: 12)),
                  )
                ]),
          ),
        ],
      ),
    )));
  }
}

class TitleTobacco extends StatelessWidget {
  final String title;
  final String value;
  const TitleTobacco({
    Key key, this.title, this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$title :',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
          Flexible(
                      child: Text(
              '$value',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imagePath;
  
  const ImageCard({
    Key key, this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.grey[200],
        child: Image(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
