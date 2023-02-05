import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:send_me/constants/_constant.dart';
import 'package:send_me/core/model/base_response.dart';
import 'package:send_me/core/model/booking_model.dart';

abstract class FireStoreRepo {
  Future<BaseResponse> submitBooking({
    required BookingModel data,
  });
  Future<BaseResponse> deleteRequest(String documentId);
  Stream<QuerySnapshot> getMyOrders(String uid);
}

class FireStoreRepoImpl extends FireStoreRepo {
  final firestoreInstance = FirebaseFirestore.instance;
  final String query = "orders";

  FireStoreRepoImpl();
  @override
  Future<BaseResponse> submitBooking({required BookingModel data}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await firestoreInstance.runTransaction((_) async {
        CollectionReference reference = firestoreInstance.collection(query);
        await reference.add(data.toJson());
      });
      return BaseResponse(
          status: true, title: 'Success', message: 'Order successful');
    } on SocketException {
      return BaseResponse(status: false, message: 'check internet connection');
    } catch (e) {
      return BaseResponse(status: false, title: 'Fail', message: 'Order fail');
    }
  }

  @override
  Future<BaseResponse> deleteRequest(String documentId) async {
    try {
      appPrint(documentId);
      await Future.delayed(const Duration(seconds: 1));
      DocumentReference reference =
          FirebaseFirestore.instance.collection(query).doc(documentId);
      await reference.delete();
      return BaseResponse(
          status: true, title: 'Success', message: 'Order cancled');
    } on SocketException {
      return BaseResponse(status: false, message: 'check internet connection');
    } catch (e) {
      return BaseResponse(
          status: false, title: 'Fail', message: 'An error occured');
    }
  }

  @override
  Stream<QuerySnapshot> getMyOrders(String uid) {
    return FirebaseFirestore.instance
        .collection(query)
        .where("userId", isEqualTo: uid)
        .orderBy('bookingDate', descending: true)
        .snapshots();
  }
}
