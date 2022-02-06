// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_c_admin/screens/EmailTempConPage.dart';
import 'package:d_c_admin/screens/smsPage.dart';
import 'package:d_c_admin/widgets/emailTempConPageAfterSearch.dart';
import 'package:flutter/material.dart';

class ConstructorSearch extends StatefulWidget {
  const ConstructorSearch({
    Key? key,
  }) : super(key: key);

  static const routeName = '/constructors-search';

  @override
  State<ConstructorSearch> createState() => _ConstructorSearchState();
}

class _ConstructorSearchState extends State<ConstructorSearch> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference allNoteCollection =
      FirebaseFirestore.instance.collection('Constructors');

  List<DocumentSnapshot> documents = [];

  TextEditingController searchController = TextEditingController();
  late String searchText = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    searchController.addListener(() {
      searchText = searchController.text;
      setState(() {});
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldColor = Colors.white70;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: const Text(
          'Constructor Search',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              height: 61,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 3, color: Colors.red),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Center(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search by name or ID',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: allNoteCollection.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                }

                documents = snapshot.data!.docs;

                if (searchText.isNotEmpty && searchText.length != 28) {
                  documents = documents.where((element) {
                    return element
                        .get('Name')
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase());
                  }).toList();
                }

                if (searchText.isNotEmpty && searchText.length == 28) {
                  documents = documents.where((element) {
                    return element
                        .get('uid')
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase());
                  }).toList();
                }

                return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      print(searchText);
                      print('langht= ' + documents.length.toString());

                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(33),
                            ),
                          ),
                        ),
                        confirmDismiss: (_) {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('Are you sure to delete it?'),
                                  actions: [
                                    FlatButton(
                                      color: Colors.red,
                                      textColor:
                                          Color.fromRGBO(255, 255, 255, 1),
                                      onPressed: () {
                                        allNoteCollection
                                            .doc(documents[index]['uid'])
                                            .delete();

                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text('Yes'),
                                    ),
                                    FlatButton(
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text('No'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33),
                            ),
                            color: Colors.white,
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 7),
                                  Center(
                                    child: CircleAvatar(
                                      radius: 33,
                                      backgroundImage: NetworkImage(
                                          documents[index]['image']),
                                    ),
                                  ),
                                  SizedBox(height: 20),

                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Name: ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: documents[index]['Name'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'City: ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: documents[index]['Name'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Cnic: ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: documents[index]['cnic'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Email: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['email'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Description: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['description'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Experience: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['experience'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Expertise: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['expertise'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Rating: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['myRating']
                                            .toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Orders: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['orders'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Phone No: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['phone'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Total Rating: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['totalRating'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Total Reviews: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['totalReviews'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Type: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['type'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),

                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'uID: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]['uid'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),
                                  ////////////////////////////////////////////////////////////////////////////////////////////////

                                  const SizedBox(height: 5),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FlatButton(
                                          textColor: Colors.white,
                                          color: Colors.green,
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              SmsSend.routeName,
                                              arguments: {
                                                'phone': documents[index]
                                                    ['phone'],
                                                'color': Colors.red
                                              },
                                            );
                                          },
                                          child: const Text('Send SMS')),
                                      FlatButton(
                                          textColor: Colors.white,
                                          color: Color.fromRGBO(244, 67, 54, 1),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                EmailTempConPageAfterSearch
                                                    .routeName,
                                                arguments: documents[index]
                                                    ['email']);
                                          },
                                          child: const Text('Send an email'))
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
