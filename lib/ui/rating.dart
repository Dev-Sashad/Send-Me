// import 'package:flutter/material.dart';
// import 'package:reaprite/index_state.dart';
// import 'package:reaprite/model/user.dart';
// import 'package:reaprite/routes.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class Rating extends StatefulWidget {
//   User _user;
//   Rating(this._user, {Key key}) : super(key: key);

//   @override
//   _RatingState createState() {
//     return _RatingState();
//   }
// }

// class _RatingState extends State<Rating> {
//   int index = 0;
//   bool clicked = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SimpleDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       contentPadding:
//           EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0, top: 30.0),
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //for(int i=0; i<message.length; i++)
//             Container(
//                 margin: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
//                 child: Text("How would you rate your experience with Reaprite?",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontFamily: "Carmen Sans",
//                         fontSize: 14.0,
//                         color: Color(0xFF00053A)))),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 for (int i = 5; i > 0; i--)
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         clicked = true;
//                         index = i;
//                       });
//                     },
//                     child: Container(
//                       //alignment: Alignment.center,
//                       margin:
//                           EdgeInsets.only(left: i == 0 ? 0.0 : 5.0, top: 20.0),
//                       child: Icon(Icons.star,
//                           size: 35.0,
//                           color: index <= i && clicked
//                               ? Colors.amber
//                               : Color(0xFFDEDEDE)),
//                     ),
//                   ),
//               ],
//             ),
//             Container(
//               alignment: Alignment.center,
//               height: 1.0,
//               //width: MediaQuery.of(context).size.width,
//               margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
//               color: Color(0xFFDEDEDE),
//             ),
//             clicked
//                 ? GestureDetector(
//                     onTap: () {
//                       saveRating(true);
//                       IndexState.openStore();
//                       Navigator.of(context, rootNavigator: true).pop('dialog');
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context, rootNavigator: true)
//                                     .pop('dialog');
//                               },
//                               child: Material(
//                                 color: Colors.transparent,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   margin: EdgeInsets.only(
//                                       left: 40.0,
//                                       right: 40.0,
//                                       top: MediaQuery.of(context).size.height /
//                                           4,
//                                       bottom: MediaQuery.of(context)
//                                                   .size
//                                                   .height <
//                                               670
//                                           ? MediaQuery.of(context).size.height /
//                                               3
//                                           : MediaQuery.of(context).size.height <
//                                                   750
//                                               ? 3.8
//                                               : MediaQuery.of(context)
//                                                       .size
//                                                       .height /
//                                                   2.8),
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius:
//                                           BorderRadius.circular(15.0)),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                           margin: EdgeInsets.only(
//                                               top: 75.0,
//                                               left: 20.0,
//                                               right: 20.0),
//                                           child: Text(
//                                               "Thank you for taking your time to rate us.",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   fontFamily: "Carmen Sans",
//                                                   fontSize: 18.0,
//                                                   color: Color(0xFF00053A),
//                                                   fontWeight:
//                                                       FontWeight.bold))),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         margin: EdgeInsets.only(top: 25.0),
//                                         decoration: BoxDecoration(
//                                             color: Color(0xFF0D1884),
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0)),
//                                         width: 200,
//                                         padding: EdgeInsets.only(
//                                             top: 15.0,
//                                             bottom: 15.0,
//                                             left: 20.0,
//                                             right: 20.0),
//                                         child: Text("CLOSE",
//                                             style: TextStyle(
//                                                 fontFamily: "Carmen Sans",
//                                                 fontSize: 16.0,
//                                                 color: Colors.white)),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           });
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       margin: EdgeInsets.only(top: 25.0),
//                       decoration: BoxDecoration(
//                           color: Color(0xFF0D1884),
//                           borderRadius: BorderRadius.circular(10.0)),
//                       width: 200,
//                       padding: EdgeInsets.only(
//                           top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
//                       child: Text("PROCEED",
//                           style: TextStyle(
//                               fontFamily: "Carmen Sans",
//                               fontSize: 16.0,
//                               color: Colors.white)),
//                     ),
//                   )
//                 : GestureDetector(
//                     onTap: () {
//                       Navigator.of(context, rootNavigator: true).pop('dialog');
//                       saveRating(false);
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       margin: EdgeInsets.only(top: 25.0),
//                       child: Text(
//                         "NOT NOW",
//                         style: TextStyle(
//                             color: Color(0xFFDEDEDE),
//                             fontSize: 16.0,
//                             fontFamily: "Carmen Sans"),
//                       ),
//                     ),
//                   ),
//           ],
//         )
//       ],
//     );
//   }

//   saveRating(bool val) async {
//     try {
//       final response = await http.post(
//           Uri.parse(Routes.baseUrl + Routes.ratings),
//           body: <String, String>{"token": widget._user.message.token});
//       // print("§§§§§=====");
//       // print(response.body);
//     } catch (err) {}
//     // SharedPreferences pref = await SharedPreferences.getInstance();
//     // pref.setBool("rite-rated", val);
//   }
// }
