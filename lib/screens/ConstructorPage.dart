// ignore_for_file: deprecated_member_use, prefer_const_constructors, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_c_admin/screens/EmailTempConPage.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ConstructorPage extends StatefulWidget {
  const ConstructorPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/constructor-page';

  @override
  State<ConstructorPage> createState() => _ConstructorPageState();
}

class _ConstructorPageState extends State<ConstructorPage> {
  late double shimmerContainerWidth;

  @override
  void initState() {
    shimmerContainerWidth = 200;
    Future.delayed(Duration(seconds: 6), () {
      shimmerContainerWidth = 0;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> contructors =
        fireStore.collection('Constructors').snapshots();

    Color scaffoldColor = Colors.white54;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: StreamBuilder(
        stream: contructors,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          final constructorData = snapshot.requireData;

          List<DocumentSnapshot> constructorDataNotApproved = [];
          for (var element in constructorData.docs) {
            if (element["isApproved"] == false) {
              constructorDataNotApproved.add(element);
            }
          }

          if (constructorDataNotApproved.isEmpty) {
            return Center(
                child: Text(
              'No Pending Data',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ));
          }

          return ListView.builder(
              itemCount: constructorDataNotApproved.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 7,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                child: Image.network(
                                  constructorDataNotApproved[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Container(
                                  width: double.infinity,
                                  height: shimmerContainerWidth,
                                  child: Image.network(
                                    constructorDataNotApproved[index]['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
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
                                  text: constructorDataNotApproved[index]
                                      ['Name'],
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
                                  text: constructorDataNotApproved[index]
                                      ['city'],
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
                                  text: constructorDataNotApproved[index]
                                      ['cnic'],
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
                                text: constructorDataNotApproved[index]
                                    ['email'],
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
                                text: constructorDataNotApproved[index]
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
                                text: constructorDataNotApproved[index]
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
                                text: constructorDataNotApproved[index]
                                    ['expertise'],
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FlatButton(
                                textColor: Colors.white,
                                color: Colors.green,
                                onPressed: () {
                                  print('ID=' +
                                      constructorDataNotApproved[index].id);
                                  FirebaseFirestore.instance
                                      .collection('Constructors')
                                      .doc(constructorDataNotApproved[index].id)
                                      .update({'isApproved': true});
                                },
                                child: const Text('Accept'),
                              ),
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
                                                    constructorDataNotApproved[
                                                            index]
                                                        .id);
                                                FirebaseFirestore.instance
                                                    .collection('Constructors')
                                                    .doc(
                                                        constructorDataNotApproved[
                                                                index]
                                                            .id)
                                                    .delete();
                                                Navigator.of(context).pushNamed(
                                                  EmailTempConPage.routeName,
                                                  arguments: constructorData
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
