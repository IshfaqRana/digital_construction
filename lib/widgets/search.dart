// ignore_for_file: deprecated_member_use, prefer_const_constructors
import 'package:d_c_admin/api/wagerApi.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_c_admin/providers/firebase-provider.dart';
import 'package:d_c_admin/screens/EmailTempWagPage.dart';
import 'package:d_c_admin/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class searchPage extends StatefulWidget {
  const searchPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/wagers-page';

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> wagers =
        fireStore.collection('Wagers').snapshots();

    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'J Search',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.ac_unit_sharp),
          )
        ],
      ),
      body: StreamBuilder(
        stream: wagers,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          final wagerData = snapshot.requireData;

          List<DocumentSnapshot> wagerDataNotApproved = [];

          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,

                //     color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {},
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      //  labelText: 'Search',
                      labelStyle: TextStyle(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: wagerData.docs.length,
                    itemBuilder: (context, index) {
                      return wagerData.docs.isEmpty
                          ? Center(
                              child: Text(
                                'No Pending Request',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          : Card(
                              elevation: 5,
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
                                            wagerData.docs[index]['image']),
                                      ),
                                    ),
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
                                            text: wagerData.docs[index]['Name'],
                                            style:
                                                TextStyle(color: Colors.black),
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
                                            text: wagerData.docs[index]['city'],
                                            style:
                                                TextStyle(color: Colors.black),
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
                                            text: wagerData.docs[index]['cnic'],
                                            style:
                                                TextStyle(color: Colors.black),
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
                                          text: wagerData.docs[index]['email'],
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
                                          text: wagerData.docs[index]
                                              ['description'],
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
                                          text: wagerData.docs[index]
                                              ['experience'],
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
                                          text: wagerData.docs[index]
                                              ['expertise'],
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
                                          text: wagerData.docs[index]
                                                  ['myRating']
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
                                          text: wagerData.docs[index]['orders'],
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
                                          text: wagerData.docs[index]['phone'],
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
                                          text: wagerData.docs[index]
                                              ['totalRating'],
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
                                          text: wagerData.docs[index]
                                              ['totalReviews'],
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
                                          text: wagerData.docs[index]['type'],
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
                                          text: wagerData.docs[index]['uid'],
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
                                              print('ID=' +
                                                  wagerData.docs[index].id);
                                              FirebaseFirestore.instance
                                                  .collection('Wagers')
                                                  .doc(wagerData.docs[index].id)
                                                  .update({'isApproved': true});
                                            },
                                            child: const Text('Accept')),
                                        FlatButton(
                                            textColor: Colors.white,
                                            color: Colors.red,
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        'Are you sure to delete it?'),
                                                    actions: [
                                                      FlatButton(
                                                        textColor: Colors.white,
                                                        color: Colors.red,
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();

                                                          print('ID=' +
                                                              wagerDataNotApproved[
                                                                      index]
                                                                  .id);
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Wagers')
                                                              .doc(
                                                                  wagerDataNotApproved[
                                                                          index]
                                                                      .id)
                                                              .delete();

                                                          Navigator.of(context)
                                                              .pushNamed(
                                                            EmailTempWagPage
                                                                .routeName,
                                                            arguments: wagerData
                                                                    .docs[index]
                                                                ['email'],
                                                          );
                                                        },
                                                        child: Text('Yes'),
                                                      ),
                                                      FlatButton(
                                                        textColor: Colors.white,
                                                        color: Colors.green,
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                        child: Text('No'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text('Reject'))
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
