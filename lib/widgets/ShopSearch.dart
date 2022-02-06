// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_c_admin/screens/smsPage.dart';
import 'package:d_c_admin/widgets/emailTempShopPageAfterSearch.dart';
import 'package:flutter/material.dart';

import 'emailTempWagPageAfterSearch.dart';

class ShopSearch extends StatefulWidget {
  const ShopSearch({
    Key? key,
  }) : super(key: key);

  static const routeName = '/shop-search';

  @override
  State<ShopSearch> createState() => _ShopSearchState();
}

class _ShopSearchState extends State<ShopSearch> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference allNoteCollection =
      FirebaseFirestore.instance.collection('Shops');

  List<DocumentSnapshot> documents = [];

  TextEditingController searchController = TextEditingController();
  late String searchText = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Stream<QuerySnapshot> shops =
        fireStore.collection('Shops').snapshots();
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
        elevation: 0.0,
        backgroundColor: Colors.purple,
        title: const Text(
          'Shop Search',
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
                border: Border.all(width: 3, color: Colors.purple),
                borderRadius: BorderRadius.circular(23),
              ),
              //   padding: EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blueGrey,
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

                if (searchText.isNotEmpty) {
                  documents = documents.where((element) {
                    return element
                        .get('shopName')
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase());
                  }).toList();
                }

                return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
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
                                        //////////////////////////////////

                                        allNoteCollection
                                            .doc(documents[index]
                                                ['shopOwnerUid'])
                                            .delete();

                                        //   setState(() {});

////////////////////////////////////////////////
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
                            color: Color.fromARGB(255, 255, 255, 255),
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
                                          documents[index]['shopImage']),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Shop Name: ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: documents[index]['shopName'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Shop Owner Name: ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: documents[index]
                                              ['shopOwnerName'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Owner Email Address: ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: documents[index]
                                              ['shopOwnerEmailName'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Owner Phone No: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: documents[index]
                                                ['shopOwnerPhoneNo']
                                            .toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),
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
                                                  "phone": documents[index]
                                                          ['shopOwnerPhoneNo']
                                                      .toString(),
                                                  "color": Colors.purple,
                                                });
                                          },
                                          child: const Text('Send SMS')),
                                      FlatButton(
                                          textColor: Colors.white,
                                          color: Color.fromRGBO(244, 67, 54, 1),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              EmailTempShopPageAfterSearch
                                                  .routeName,
                                              arguments: documents[index]
                                                  ['shopOwnerEmailName'],
                                            );
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
