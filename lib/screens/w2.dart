// wagerPage => w2
// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_c_admin/screens/EmailTempWagPage.dart';
import 'package:flutter/material.dart';

class W2 extends StatelessWidget {
  const W2({
    Key? key,
  }) : super(key: key);

  static const routeName = '/w2-page';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> wagers =
        fireStore.collection('Wagers').snapshots();

    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Pending Wagers',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (_) => MyHomePage()));
            },
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

          wagerData.docs.forEach((element) {
            if (element['isApproved'] == false) {
              wagerDataNotApproved.add(element);
            }
          });

          return ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  width: 0,
                  height: 0,
                );
              },
              itemCount: wagerDataNotApproved.length,
              itemBuilder: (context, index) {
                return wagerDataNotApproved.isEmpty
                    ? Center(
                        child: Text(
                          'No Pending Request',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                child: Image.network(
                                  wagerDataNotApproved[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 13,
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
                                      text: wagerDataNotApproved[index]['Name'],
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
                                      text: wagerDataNotApproved[index]['city'],
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
                                      text: wagerDataNotApproved[index]['cnic'],
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
                                    text: wagerDataNotApproved[index]['email'],
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
                                    text: wagerDataNotApproved[index]
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
                                    text: wagerDataNotApproved[index]
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
                                    text: wagerDataNotApproved[index]
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
                                    text: wagerDataNotApproved[index]
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
                                    text: wagerDataNotApproved[index]['orders'],
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
                                    text: wagerDataNotApproved[index]['phone'],
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
                                    text: wagerDataNotApproved[index]
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
                                    text: wagerDataNotApproved[index]
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
                                    text: wagerDataNotApproved[index]['type'],
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
                                    text: wagerDataNotApproved[index]['uid'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              )),
                              const SizedBox(height: 5),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FlatButton(
                                      textColor: Colors.white,
                                      color: Colors.green,
                                      onPressed: () {
                                        print('ID=' +
                                            wagerDataNotApproved[index].id);
                                        FirebaseFirestore.instance
                                            .collection('Wagers')
                                            .doc(wagerDataNotApproved[index].id)
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
                                                    Navigator.of(context).pop();

                                                    print('ID=' +
                                                        wagerDataNotApproved[
                                                                index]
                                                            .id);
                                                    FirebaseFirestore.instance
                                                        .collection('Wagers')
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
                                                          .docs[index]['email'],
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
              });
        },
      ),
    );
  }
}
