import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../menus.dart';
import '../strings.dart';

class Features extends StatefulWidget {
  final String name = 'Features';
  Key get key => Menus.keys[name];
  @override
  State<StatefulWidget> createState() {
    return _Features();
  }
}

class _Features extends State<Features> {
  Map<String, List<String>> features = {
    'Smart Search': [
      'search.png',
      'Dapat menghubungkan penjual dan pembeli terutama dalam lokasi radius yang dekat dan mudah diakses secara langsung'
    ],
    'Smart Map': [
      'map.png',
      'Lokasi pedagang ditentukan dengan posisi terdekat dengan pembeli. Fitur ini akan menggunakan maps, dapat digunakan saat mencari katalog barang dan juga saat pembelian barang. Selain itu lokasi pedagang untuk pedagang keliling akan terus di update sehingga pergerakannya dapat diketahui oleh pengguna. Fitur lokasi juga dapat diimplementasikan kepada pedagang untuk mengetahui posisi pembeli, dalam kasus ini untuk mengamankan privasi pembeli, posisi pembeli akan dikelompokkan kedalam radius terbaik lokasi penjualan pedagang sehingga lokasi pembeli tidak ditampilkan secara spesifik.'
    ],
    'Smart Cashier': [
      'cashier.png',
      'Fitur ini memungkinkan kalkulasi pembelian barang dapat digunakan dengan melakukan scanning barcode sehingga perhitungan barang dapat lebih cepat dan menurunkan kemungkinan kesalahan perhitungan manual. Karena kemungkinan barang yang tidak memiliki barcode, identifikasi juga dapat dilakukan dengan klasifikasi barang manual atau menggunakan image recognition (jika penjual juga lupa barang tersebut).'
    ],
    'Smart Counting': [
      'maths.png',
      'Fitur analisis data ini dapat diintegrasikan untuk memberikan insight terhadap statistik penjualan. Data ini dapat meliputi barang terjual, barang yang perlu di restock, dan data keuangan.'
    ],
    'Delivery': [
      'delivery-truck.png',
      'Fitur ini dapat diaplikasikan jika pedang di tempat memiliki kurir untuk pengiriman barang. Kurir juga dapat menentukan seberapa jauh (maksimal) penggunaan fitur pengiriman barang ataupun mengaplikasikan tarif untuk pengiriman barang.'
    ],
    'Smart Payment': [
      'debit-card.png',
      'Dapat melakukan pembayaran melalui e-wallet/e-payment'
    ],
    'Price Catalog': [
      'price-tag.png',
      'Fitur ini akan menampilkan katalog produk, stok dan harga dari produk yang dijual oleh pedagang. Jika memungkinkan. Katalog juga dapat dicari secara global (dari beberapa toko) yang disusun dari lokasi terdekat, atau pengguna juga dapat melihat barang dari toko tertentu.'
    ],
    'Notification': [
      'notification.png',
      'Fitur notifikasi ini dapat digunakan oleh pembeli untuk mendapatkan informasi dari pedagang keliling yang posisinya sedang dekat dengan pembeli. Pembeli dapat memberikan filter tertentu terhadap kategori apa yang diinginkan pembeli, atau memilih mendapatkan notifikasi untuk pedangang tertentu.'
    ],
    'Image Recognition': [
      'image.png',
      'Pedagang warung yang lupa harganya dapat menggunakan fitur ini untuk mengenali barang tersebut atau mendapatkan informasi barang saat melakukan entri data untuk mendapatkan nama barang yang umum, harga barang rekomendasi, dan info lainnya. Informasi barang dari image recognition ini didapat jika database server dari aplikasi telah memiliki data yang cukup banyak sehingga Learning AI yang digunakan semakin akurat. Untuk barang yang memiliki barcode, diutamakan menggunakan barcode terlebih dahulu untuk melakukan identifikasi. Fitur ini juga dapat digunakan oleh pembeli untuk mengetahui barang tersebut dan untuk mengetahui dimana tempat terdekat untuk membelinya.'
    ],
    'Ads': [
      'ads.png',
      'Fitur ini akan menjadi media pengembang untuk mendapatkan pendapatan. Periklanan dapat disewakan kepada penjual dari aplikasi ini ataupun menampilkan iklan dari luar.'
    ],
    'Instant Message': [
      'chat.png',
      'Perpesanan instan dapat digunakan untuk media komunikasi antara penjual dan pembeli.'
    ]
  };

  List<String> defaultDesc = ['Features', Strings.fitur];

  List<String> desc;
  CarouselController buttonCarouselController = CarouselController();

  Timer t;

  void initState() {
    super.initState();
    desc = defaultDesc;
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Material(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50),
          alignment: Alignment.bottomLeft,
          child: Column(
            children: [
              CarouselSlider(
                items: List.generate(features.length, (index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              width: 200,
                              padding: EdgeInsets.all(12),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    if (t != null && t.isActive) t.cancel();
                                    t = Timer(const Duration(seconds: 4), () {
                                      setState(() {
                                        desc = defaultDesc;
                                      });
                                    });
                                    buttonCarouselController.animateToPage(
                                        index,
                                        curve: Curves.easeInOut);
                                    setState(() {
                                      desc = [
                                        features.keys.toList()[index],
                                        features[features.keys.toList()[index]]
                                            [1]
                                      ];
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/svg/${(features[features.keys.toList()[index]])[0]}',
                                        height: 75,
                                      ),
                                      Text(features.keys.toList()[index]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  );
                }).toList(),
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 250 / size,
                    initialPage: 0,
                    aspectRatio: 9 / 16),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(desc[0],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ))),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    desc[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ));
  }
}
