// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:send_me/core/model/base_response.dart';
// import 'package:send_me/core/model/booking_model.dart';
// import 'package:send_me/core/services/notification_service.dart';

// abstract class FireStoreRepo {
//   Future<BaseResponse> submitBookingNC({
//     required BookingModel data,
//    // NoneCritical? nonCritical,
//   });

//   Future<BaseResponse> submitBookingC({
//     required BookingModel data,
//    // Critical? critical,
//   });
//   Future<BaseResponse> deletePendingNC(String documentId);
//   Future<BaseResponse> deletePendingC(String documentId);
//   Future<BaseResponse> confirmArrival({bool isCritical, String documentId});
//   Future<BaseResponse> missedArrival({bool isCritical, String documentId});
//   Stream<QuerySnapshot<Map<String, dynamic>>> getMyPendingNCBookings(
//       String uid);
//   Stream<QuerySnapshot<Map<String, dynamic>>> getMySuccessNCBookings(
//       String uid);
//   Stream<QuerySnapshot<Map<String, dynamic>>> getMyPendingCBookings(String uid);
//   Stream<QuerySnapshot<Map<String, dynamic>>> getMySuccessCBookings(String uid);
//   Stream<QuerySnapshot<Map<String, dynamic>>> getDoctors();
//   Future<QuerySnapshot<Map<String, dynamic>>> getAllCBk();
//   Future<QuerySnapshot<Map<String, dynamic>>> getAllNCBK();
// }

// class FireStoreRepoImpl extends FireStoreRepo {
//   final firestoreInstance = FirebaseFirestore.instance;
//   final NotificationHelper _notificationHelper;

//   FireStoreRepoImpl(this._notificationHelper);
//   @override
//   Future<BaseResponse> submitBookingNC(
//       {required BookingModel data, NoneCritical? nonCritical}) async {
//     try {
//       await Future.delayed(Duration(seconds: 1));
//       String notifyDate = DateTime.now().add(Duration(minutes: 5)).toString();
//       if (nonCritical == NoneCritical.success) {
//         await firestoreInstance.runTransaction((_) async {
//           CollectionReference reference =
//               firestoreInstance.collection('nCSuccessBookings');
//           await reference.add(data.toJson());
//         }).then((value) async {
//           var time = formatTimeOnly(data.date);
//           DateTime notifyMe =
//               DateTime.parse(data.date!).subtract(Duration(minutes: 5));
//           await _notificationHelper.createSheduledAwesome(
//               date: notifyMe,
//               title: data.name!,
//               body: 'Reminder, Your Scheduled time is $time');
//           await _notificationHelper.sendAndRetrieveMessage(
//               title: data.name!,
//               body: 'Your Scheduled time is $time',
//               isSch: true,
//               date: newFormatDate(notifyDate).toString());
//         });
//         return BaseResponse(
//             status: true, title: 'Success', message: 'Booking successful');
//       } else {
//         firestoreInstance.runTransaction((Transaction transaction) async {
//           CollectionReference reference =
//               firestoreInstance.collection('nCPendingBookings');
//           await reference.add(data.toJson());
//         }).then((value) async {
//           await _notificationHelper.sendAndRetrieveMessage(
//               title: data.name!,
//               body: 'check Booking history later for your scheduled time',
//               isSch: false);
//         });
//         return BaseResponse(
//             status: true, title: 'Sucess', message: 'Booking successful');
//       }
//     } on SocketException {
//       return BaseResponse(status: false, message: 'check internet connection');
//     } catch (e) {
//       return BaseResponse(
//           status: false, title: 'Fail', message: 'Booking fail');
//     }
//   }

//   @override
//   Future<BaseResponse> submitBookingC(
//       {required BookingModel data, Critical? critical}) async {
//     try {
//       await Future.delayed(Duration(seconds: 1));
//       String notifyDate = DateTime.now().add(Duration(minutes: 5)).toString();
//       if (critical == Critical.success) {
//         await firestoreInstance.runTransaction((_) async {
//           CollectionReference reference =
//               firestoreInstance.collection('cSuccessBookings');
//           await reference.add(data.toJson());
//         }).then((value) async {
//           var time = formatTimeOnly(data.date);
//           DateTime notifyMe =
//               DateTime.parse(data.date!).subtract(Duration(minutes: 5));
//           await _notificationHelper.createSheduledAwesome(
//               date: notifyMe,
//               title: data.name!,
//               body: 'Reminder, Your Scheduled time is $time');
//           await _notificationHelper.sendAndRetrieveMessage(
//               title: data.name!,
//               body: 'Your Scheduled time is $time',
//               isSch: true,
//               date: newFormatDate(notifyDate).toString());
//         });
//         return BaseResponse(
//             status: true, title: 'Sucess', message: 'Booking successful');
//       } else {
//         firestoreInstance.runTransaction((Transaction transaction) async {
//           CollectionReference reference =
//               firestoreInstance.collection('cPendingBookings');
//           await reference.add(data.toJson());
//         }).then((value) async {
//           await _notificationHelper.sendAndRetrieveMessage(
//               title: data.name!,
//               body: 'check Booking history later for your scheduled time',
//               isSch: false);
//         });
//         return BaseResponse(
//             status: true, title: 'Success', message: 'Booking successful');
//       }
//     } on SocketException {
//       return BaseResponse(status: false, message: 'check internet connection');
//     } catch (e) {
//       return BaseResponse(
//           status: false, title: 'Fail', message: 'Booking fail');
//     }
//   }

//   Future<BaseResponse> deletePendingNC(String documentId) async {
//     try {
//       appPrint(documentId);
//       await Future.delayed(Duration(seconds: 1));
//       DocumentReference reference = FirebaseFirestore.instance
//           .collection('nCPendingBookings')
//           .doc(documentId);
//       await reference.delete();
//       return BaseResponse(
//           status: true, title: 'Success', message: 'sucessfully delete');
//     } on SocketException {
//       return BaseResponse(status: false, message: 'check internet connection');
//     } catch (e) {
//       return BaseResponse(
//           status: false, title: 'Fail', message: 'An Error occured');
//     }
//   }

//   Future<BaseResponse> deletePendingC(String documentId) async {
//     try {
//       print(documentId);
//       await Future.delayed(Duration(seconds: 1));
//       DocumentReference reference = FirebaseFirestore.instance
//           .collection('cPendingBookings')
//           .doc(documentId);
//       await reference.delete();
//       return BaseResponse(
//           status: true, title: 'Success', message: 'sucessfully delete');
//     } on SocketException {
//       return BaseResponse(status: false, message: 'check internet connection');
//     } catch (e) {
//       return BaseResponse(
//           status: false, title: 'Fail', message: 'An Error occured');
//     }
//   }

//   Future<BaseResponse> confirmArrival(
//       {bool? isCritical, String? documentId}) async {
//     try {
//       appPrint(documentId!);
//       if (isCritical!) {
//         DocumentReference reference = FirebaseFirestore.instance
//             .collection('cSuccessBookings')
//             .doc(documentId);
//         await reference.update({"arrivalStatus": "completed"});
//       } else {
//         DocumentReference reference = FirebaseFirestore.instance
//             .collection('nCSuccessBookings')
//             .doc(documentId);

//         await reference.update({"arrivalStatus": "completed"});
//       }
//       return BaseResponse(
//           status: true,
//           title: 'Welcome',
//           message: 'kindly go to the next available doctor');
//     } on SocketException {
//       return BaseResponse(status: false, message: 'check internet connection');
//     } catch (e) {
//       return BaseResponse(
//           status: false, title: 'Fail', message: 'An Error occured');
//     }
//   }

//   Future<BaseResponse> missedArrival(
//       {bool? isCritical, String? documentId}) async {
//     try {
//       print(documentId!);
//       if (isCritical!) {
//         DocumentReference reference = FirebaseFirestore.instance
//             .collection('cSuccessBookings')
//             .doc(documentId);

//         await reference.update({"arrivalStatus": "missed"});
//       } else {
//         DocumentReference reference = FirebaseFirestore.instance
//             .collection('nCSuccessBookings')
//             .doc(documentId);

//         await reference.update({"arrivalStatus": "missed"});
//       }
//       return BaseResponse(
//           status: true,
//           title: 'Ooops!',
//           message:
//               'You are late for this appointment. Kindly contact support to be reffered to delayed point');
//     } on SocketException {
//       return BaseResponse(status: false, message: 'check internet connection');
//     } catch (e) {
//       return BaseResponse(
//           status: false, title: 'Fail', message: 'An Error occured');
//     }
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> getDoctors() {
//     return firestoreInstance
//         .collection('doctors')
//         .orderBy("patients")
//         .snapshots();
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> getMyPendingNCBookings(
//       String uid) {
//     return FirebaseFirestore.instance
//         .collection('nCPendingBookings')
//         .where("userId", isEqualTo: uid)
//         .orderBy('bookingDate', descending: true)
//         .snapshots();
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> getMySuccessNCBookings(
//       String uid) {
//     return FirebaseFirestore.instance
//         .collection('nCSuccessBookings')
//         .where("userId", isEqualTo: uid)
//         .orderBy('bookingDate', descending: true)
//         .snapshots();
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> getMyPendingCBookings(
//       String uid) {
//     return FirebaseFirestore.instance
//         .collection('cPendingBookings')
//         .where("userId", isEqualTo: uid)
//         .orderBy('bookingDate', descending: true)
//         .snapshots();
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> getMySuccessCBookings(
//       String uid) {
//     return FirebaseFirestore.instance
//         .collection('cSuccessBookings')
//         .where("userId", isEqualTo: uid)
//         .orderBy('bookingDate', descending: true)
//         .snapshots();
//   }

//   Future<QuerySnapshot<Map<String, dynamic>>> getAllCBk() async {
//     var data = await FirebaseFirestore.instance
//         .collection('cSuccessBookings')
//         .where("arrivalStatus", isEqualTo: "pending")
//         .orderBy('bookingDate', descending: true)
//         .get();
//     return data;
//   }

//   Future<QuerySnapshot<Map<String, dynamic>>> getAllNCBK() async {
//     var data = await FirebaseFirestore.instance
//         .collection('nCSuccessBookings')
//         .where("arrivalStatus", isEqualTo: "pending")
//         .orderBy('bookingDate', descending: true)
//         .get();
//     return data;
//   }
// }

// // class FireStoreService {
// //   final firestoreInstance = FirebaseFirestore.instance;
// //   final NotificationHelper _notificationHelper = locator<NotificationHelper>();
// //   var uuid = Uuid();
//   //var data = FirebaseAuth.instance.currentUser;
//   // Future<dynamic> submitBookingNC(String date, String importance,
//   //     String purpose, NoneCritical nonCritical, String uid, String name) async {
//   //   print('the purpose is $purpose');
//   //   checkSession().then((value) {
//   //     String bookingDate = DateTime.now().toString();
//   //     String notifyDate = DateTime.now().add(Duration(minutes: 5)).toString();
//   //     var referenceId = uuid.v4();
//   //     if (nonCritical == NoneCritical.success) {
//   //       firestoreInstance.runTransaction((_) async {
//   //         CollectionReference reference =
//   //             firestoreInstance.collection('nCSuccessBookings');
//   //         await reference.add({
//   //           "dateTime": date,
//   //           // "doctorName": doctorName,
//   //           // "doctorId": doctorId,
//   //           "priority": importance,
//   //           "purpose": purpose,
//   //           "userId": uid,
//   //           "userName": name,
//   //           "referenceId": referenceId,
//   //           "bookingDate": bookingDate,
//   //           "arrivalStatus": "pending"
//   //         });
//   //       }).then((value) async {
//   //         var time = formatTimeOnly(date);
//   //         DateTime notifyMe =
//   //             DateTime.parse(date).subtract(Duration(minutes: 5));
//   //         await _notificationHelper.createSheduledAwesome(
//   //             date: notifyMe,
//   //             title: name,
//   //             body: 'Reminder, Your Scheduled time is $time');
//   //         await _notificationHelper.sendAndRetrieveMessage(
//   //             title: name,
//   //             body: 'Your Scheduled time is $time',
//   //             isSch: true,
//   //             date: newFormatDate(notifyDate).toString());

//   //         return SuccessModel(value);
//   //       }).onError((error, stackTrace) {
//   //         return error;
//   //       });
//   //     } else {
//   //       firestoreInstance.runTransaction((Transaction transaction) async {
//   //         CollectionReference reference =
//   //             firestoreInstance.collection('nCPendingBookings');
//   //         await reference.add({
//   //           // "dateTime": date,
//   //           // "doctorName": doctorName,
//   //           // "doctorId": doctorId,
//   //           "priority": importance,
//   //           "purpose": purpose,
//   //           "userId": uid,
//   //           "userName": name,
//   //           "referenceId": referenceId,
//   //           "bookingDate": bookingDate,
//   //           "arrivalStatus": "pending"
//   //         });
//   //       }).then((value) async {
//   //         await _notificationHelper.sendAndRetrieveMessage(
//   //             title: name,
//   //             body: 'check Booking history later for your scheduled time',
//   //             isSch: false);
//   //         return SuccessModel(value);
//   //       }).onError((error, stackTrace) {
//   //         return error;
//   //       });
//   //     }
//   //   });
//   // }

//   // Future<dynamic> submitBookingC(
//   //     String date, String importance, String purpose, Critical critical) async {
//   //   print('the purpose is $purpose');
//   //   checkSession().then((value) {
//   //     var referenceId = uuid.v4();
//   //     String bookingDate = DateTime.now().toString();
//   //     String notifyDate = DateTime.now().add(Duration(minutes: 5)).toString();
//   //     if (critical == Critical.success) {
//   //       firestoreInstance.runTransaction((Transaction transaction) async {
//   //         CollectionReference reference =
//   //             firestoreInstance.collection('cSuccessBookings');
//   //         await reference.add({
//   //           "dateTime": date,
//   //           // "doctorName": doctorName,
//   //           // "doctorId": doctorId,
//   //           "priority": importance,
//   //           "purpose": purpose,
//   //           "userId": _authentication.uid,
//   //           "userName": _authentication.name,
//   //           "referenceId": referenceId,
//   //           "bookingDate": bookingDate,
//   //           "arrivalStatus": "pending"
//   //         });
//   //       }).then((value) async {
//   //         var time = formatTimeOnly(date);
//   //         DateTime notifyMe =
//   //             DateTime.parse(date).subtract(Duration(minutes: 5));
//   //         await _notificationHelper.createSheduledAwesome(
//   //             date: notifyMe,
//   //             title: _authentication.name,
//   //             body: 'Reminder, Your Scheduled time is $time');
//   //         await _notificationHelper.sendAndRetrieveMessage(
//   //             title: _authentication.name,
//   //             body: 'Your Scheduled time is $time',
//   //             isSch: true,
//   //             date: newFormatDate(notifyDate).toString());
//   //         return SuccessModel(value);
//   //       }).onError((error, stackTrace) {
//   //         return error;
//   //       });
//   //     } else {
//   //       firestoreInstance.runTransaction((Transaction transaction) async {
//   //         CollectionReference reference =
//   //             firestoreInstance.collection('cPendingBookings');
//   //         await reference.add({
//   //           "dateTime": date,
//   //           // "doctorName": doctorName,
//   //           // "doctorId": doctorId,
//   //           "priority": importance,
//   //           "purpose": purpose,
//   //           "userId": _authentication.uid,
//   //           "userName": _authentication.name,
//   //           "referenceId": referenceId,
//   //           "bookingDate": bookingDate,
//   //           "arrivalStatus": "pending"
//   //         });
//   //       }).then((value) async {
//   //         await _notificationHelper.sendAndRetrieveMessage(
//   //             title: _authentication.name,
//   //             body: 'check Booking history later for your scheduled time',
//   //             isSch: false);
//   //         return SuccessModel(value);
//   //       }).onError((error, stackTrace) {
//   //         return error;
//   //       });
//   //     }
//   //   });
//   // }

//   // Future<dynamic> deletePendingNC(String documentId) async {
//   //   print(documentId);
//   //   DocumentReference reference = FirebaseFirestore.instance
//   //       .collection('nCPendingBookings')
//   //       .doc(documentId);
//   //   await reference.delete();
//   // }

//   // Future<dynamic> deletePendingC(String documentId) async {
//   //   print(documentId);
//   //   DocumentReference reference = FirebaseFirestore.instance
//   //       .collection('cPendingBookings')
//   //       .doc(documentId);
//   //   await reference.delete();
//   // }

//   // confirmArrival(bool isCritical, String documentId) async {
//   //   print(documentId);
//   //   if (isCritical) {
//   //     DocumentReference reference = FirebaseFirestore.instance
//   //         .collection('cSuccessBookings')
//   //         .doc(documentId);
//   //     await reference.update({"arrivalStatus": "completed"});
//   //     return _progressService
//   //         .showDialog(
//   //             title: 'Welcome',
//   //             description: 'kindly go to the next available doctor')
//   //         .then((value) => _navigationService.pop());
//   //   } else {
//   //     DocumentReference reference = FirebaseFirestore.instance
//   //         .collection('nCSuccessBookings')
//   //         .doc(documentId);

//   //     await reference.update({"arrivalStatus": "completed"});
//   //     return _progressService
//   //         .showDialog(
//   //             title: 'Welcome',
//   //             description: 'kindly go to the next available doctor')
//   //         .then((value) => _navigationService.pop());
//   //   }
//   // }

//   // missedArrival(bool isCritical, String documentId) async {
//   //   print(documentId);
//   //   if (isCritical) {
//   //     DocumentReference reference = FirebaseFirestore.instance
//   //         .collection('cSuccessBookings')
//   //         .doc(documentId);

//   //     await reference.update({"arrivalStatus": "missed"});
//   //     return _progressService
//   //         .showDialog(
//   //             title: 'Ooops!',
//   //             description:
//   //                 'You are late for this appointment. Kindly contact support to be reffered to delayed point')
//   //         .then((value) => _navigationService.pop());
//   //   } else {
//   //     DocumentReference reference = FirebaseFirestore.instance
//   //         .collection('nCSuccessBookings')
//   //         .doc(documentId);

//   //     await reference.update({"arrivalStatus": "missed"});
//   //     return _progressService
//   //         .showDialog(
//   //             title: 'Ooops!',
//   //             description:
//   //                 'You are late for this appointment. Kindly contact support to be reffered to delayed point')
//   //         .then((value) => _navigationService.pop());
//   //   }
//   // }

//   // getDoctors() {
//   //   return firestoreInstance
//   //       .collection('doctors')
//   //       .orderBy("patients")
//   //       .snapshots();
//   // }

//   // getMyPendingNCBookings() {
//   //   return FirebaseFirestore.instance
//   //       .collection('nCPendingBookings')
//   //       .where("userId", isEqualTo: _authentication.uid)
//   //       .orderBy('bookingDate', descending: true)
//   //       .snapshots();
//   // }

//   // getMySuccessNCBookings() {
//   //   return FirebaseFirestore.instance
//   //       .collection('nCSuccessBookings')
//   //       .where("userId", isEqualTo: _authentication.uid)
//   //       .orderBy('bookingDate', descending: true)
//   //       .snapshots();
//   // }

//   // getMyPendingCBookings() {
//   //   return FirebaseFirestore.instance
//   //       .collection('cPendingBookings')
//   //       .where("userId", isEqualTo: _authentication.uid)
//   //       .orderBy('bookingDate', descending: true)
//   //       .snapshots();
//   // }

//   // getMySuccessCBookings() {
//   //   return FirebaseFirestore.instance
//   //       .collection('cSuccessBookings')
//   //       .where("userId", isEqualTo: _authentication.uid)
//   //       .orderBy('bookingDate', descending: true)
//   //       .snapshots();
//   // }

//   // Future<QuerySnapshot> getAllCBk() async {
//   //   var data = await FirebaseFirestore.instance
//   //       .collection('cSuccessBookings')
//   //       .where("arrivalStatus", isEqualTo: "pending")
//   //       .orderBy('bookingDate', descending: true)
//   //       .get();
//   //   return data;
//   // }

//   // Future<QuerySnapshot> getAllNCBK() async {
//   //   var data = await FirebaseFirestore.instance
//   //       .collection('nCSuccessBookings')
//   //       .where("arrivalStatus", isEqualTo: "pending")
//   //       .orderBy('bookingDate', descending: true)
//   //       .get();
//   //   return data;
//   // }
// //}
