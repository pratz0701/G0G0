import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:map/models/user.dart';
import 'package:map/models/year.dart';
import 'package:map/models/event.dart';

class DatabaseService {
  final String uid;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference eventCollection = FirebaseFirestore.instance.collection('EVENTS');
  DatabaseService({this.uid});


  Future<users> getUsers() async {
    var snap = await userCollection.doc(uid).get();

    return users.fromMap(snap.data());
  }

  /// Get a stream of a single document
  Stream<users> streamUser() {
    return userCollection.doc(uid)
        .snapshots()
        .map((snap) => users.fromMap(snap.data()) );
  }

//  Query a subcollection


  Future<Year> getMolestation(String state,String city,String year) async {
    var snap = await eventCollection.doc('Molestation').collection(state).doc(city).collection(year).doc(year).get();

    return Year.fromMap(snap.data());
  }




  Future<Year> getMurder(String state,String city,String year) async {
    var snap = await eventCollection.doc('Murder').collection(state).doc(city).collection(year).doc(year).get();

    return Year.fromMap(snap.data());
  }
  Future<Year> getDrugs(String state,String city,String year) async {
    var snap = await eventCollection.doc('Druge').collection(state).doc(city).collection(year).doc(year).get();

    return Year.fromMap(snap.data());
  }
  Future<Year> getOther(String state,String city,String year) async {
    var snap = await eventCollection.doc('Other').collection(state).doc(city).collection(year).doc(year).get();

    return Year.fromMap(snap.data());
  }
  Future<Year> getRobbery(String state,String city,String year) async {
    var snap = await eventCollection.doc('Robbery').collection(state).doc(city).collection(year).doc(year).get();

    return Year.fromMap(snap.data());
  }

  /// Get a stream of a single document
  Stream<events> streamEvent() {
    return eventCollection.doc()
        .snapshots()
        .map((snap) => events.fromMap(snap.data()) );
  }



  Future<void> addUser({String name,String uid,String email, }) {
    return userCollection
        .doc(uid)
        .update( {'name': name??'',
      'uid': uid ?? '',
      'email': email ?? '',
 });
  }



}

