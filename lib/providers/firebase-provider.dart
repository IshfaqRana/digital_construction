// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';

// // FirebaseFirestore fireStore = FirebaseFirestore.instance;
// // final Stream<QuerySnapshot> wagers = fireStore.collection('Wagers').snapshots();

// class WagerData {
//   late String uid;
//   late String name;
//   late String city;
//   late String cnic;
//   late String description;
//   late String email;
//   late String experience;
//   late String expertise;
//   late String image;
//   late String orders;
//   late String type;
//   late bool isApproved;

//   WagerData({
//     required this.uid,
//     required this.name,
//     required this.city,
//     required this.cnic,
//     required this.description,
//     required this.email,
//     required this.image,
//     required this.experience,
//     required this.expertise,
//     required this.orders,
//     required this.type,
//     required this.isApproved,
//   });
// }

// class WagerProvider with ChangeNotifier {
//   List<WagerData> _wagers = [];

//   List<WagerData> get wagers {
//     return [..._wagers];
//   }

//   List<WagerData> get approvedWagers {
//     return _wagers.where((element) => element.isApproved).toList();
//   }

//   List<WagerData> get pendingWagers {
//     return _wagers.where((element) => element.isApproved == false).toList();
//   }

//   void addWagersToProvider(
//     String uid,
//     String name,
//     String city,
//     String cnic,
//     String description,
//     String email,
//     String experience,
//     String expertise,
//     String image,
//     String orders,
//     String type,
//     bool isApproved,
//   ) {
//     _wagers.add(
//       WagerData(
//         uid: uid,
//         name: name,
//         city: city,
//         cnic: cnic,
//         description: description,
//         email: email,
//         image: image,
//         experience: experience,
//         expertise: expertise,
//         orders: orders,
//         type: type,
//         isApproved: isApproved,
//       ),
//     );

//     notifyListeners();
//   }
// }
