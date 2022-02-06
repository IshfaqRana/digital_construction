// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class WagerClass {
//   late String name;
//   late String city;
//   late String cnic;
//   late String email;
//   late String description;
//   late String experience;
//   late String expertise;
//   late int myRating;
//   late String orders;
//   late String phoneNo;
//   late String totalRating;
//   late String totalReviews;
//   late String type;
//   late String uid;
//   late String image;
//   late bool isApproved;

//   WagerClass({
//     required this.city,
//     required this.cnic,
//     required this.description,
//     required this.email,
//     required this.experience,
//     required this.expertise,
//     required this.name,
//     required this.orders,
//     required this.phoneNo,
//     required this.myRating,
//     required this.totalRating,
//     required this.totalReviews,
//     required this.type,
//     required this.image,
//     required this.isApproved,
//     required this.uid,
//   });
// }

// class WagerApi {
//   List<WagerClass> allwagers = [];
//   var url = Uri.parse(
//       'https://console.firebase.google.com/project/digital-construction-969cd/Wager.json');

//   Future<List<WagerClass>> getResult(String query) async {
//     var response = await http.get(url);
//     print(response.body);
//     final wagers = json.decode(response.body);

//     allwagers.add(
//       WagerClass(
//         city: wagers['city'],
//         cnic: wagers['cnic'],
//         description: wagers['description'],
//         email: wagers['email'],
//         experience: wagers['experience'],
//         expertise: wagers['expertise'],
//         name: wagers['Name'],
//         orders: wagers['orders'],
//         phoneNo: wagers['phone'],
//         myRating: wagers['myRating'],
//         totalRating: wagers['totalRatings'],
//         totalReviews: wagers['totalReviews'],
//         type: wagers['type'],
//         image: wagers['image'],
//         isApproved: wagers['isApproved'],
//         uid: wagers['uid'],
//       ),
//     );
//     return allwagers;

//   }
// }
