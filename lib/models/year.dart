import 'package:cloud_firestore/cloud_firestore.dart';

class Year{
  final int jan;
  final int feb;

  final int march;
  final int april;
  final int may;
  final int june;
  final int july;
  final int aug;

  final int sept;
  final int nov;
  final int dec;
  final int oct;


  Year({this.jan, this.feb, this.march, this.april, this.may, this.june, this.july, this.aug, this.sept, this.nov, this.dec, this.oct, } );
  factory Year.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Year(
      jan: doc['January']??0,
      feb: data['February']??0,
      march: data['March']??0,
      april: data['April']??0,
      may: data['May']??1,
      july: data['June']??'',
      june: data['July']??'',
      aug: data['August']??'',
      sept: data['September']??'',
      oct: data['October']??'',
      nov: data['November']??'',
      dec: data['December']??'',
    );
  }

  static Future<Year> fromMap(Map<String, dynamic> data) {}



}