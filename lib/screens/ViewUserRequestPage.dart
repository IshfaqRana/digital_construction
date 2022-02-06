// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_c_admin/widgets/Con_View_On_ID_Click.dart';
import 'package:d_c_admin/widgets/Wager_View_On_ID_Click.dart';
import 'package:flutter/material.dart';

class ViewUserRequestPage extends StatefulWidget {
  const ViewUserRequestPage({Key? key}) : super(key: key);
  static const routeName = '/view-user-request-page';

  @override
  State<ViewUserRequestPage> createState() => _ViewUserRequestPageState();
}

class _ViewUserRequestPageState extends State<ViewUserRequestPage> {
  late dynamic requestData;
  FocusNode selectableTextFocusNode = FocusNode();

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final allRequests = firestore.collection('Requests');

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.93),
      appBar: AppBar(
        elevation: 0,
        title: const Text('User Work Requests'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              height: 61,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 3, color: Colors.deepOrange),
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
                    hintText: 'Search by name',
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
                stream: allRequests.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  requestData = snapshot.data!.docs;

                  if (searchText.isNotEmpty && searchText.length != 28) {
                    requestData = requestData.where((element) {
                      return element
                          .get('name')
                          .toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase());
                    }).toList();
                  }

                  return ListView.builder(
                      itemCount: requestData.length,
                      itemBuilder: ((context, index) {
                        var checkNullContarctor =
                            requestData[index]['contractor'];
                        return Card(
                          elevation: 2.7,

                          // color: Colors.white.withOpacity(0.7),
                          margin: const EdgeInsets.all(15),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Customer Details',
                                    style: TextStyle(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 9),
                                SelectableText.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'ID : ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: requestData[index]['user'],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  focusNode: selectableTextFocusNode,
                                  onTap: () {
                                    selectableTextFocusNode.unfocus();
                                    setState(() {});
                                  },
                                ),

                                SizedBox(height: 2),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Name : ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: requestData[index]['name'],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ])),
                                SizedBox(height: 2),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Phone No : ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: requestData[index]['phone'],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ])),
                                SizedBox(height: 2),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Address : ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: requestData[index]['address'],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ])),

                                //     const Divider(),
                                SizedBox(height: 20),
                                const Center(
                                  child: Text(
                                    'Project Details',
                                    style: TextStyle(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 7),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Project ID : ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: requestData[index]['projID'],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ])),
                                SizedBox(height: 2),

                                checkNullContarctor != 'null'
                                    ? RichText(
                                        text: TextSpan(children: [
                                        const TextSpan(
                                          text: 'Start Date : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: requestData[index]['start'],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ]))
                                    : Column(
                                        children: [
                                          SizedBox(height: 2),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Start Date : ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'not applicable',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                checkNullContarctor != 'null'
                                    ? RichText(
                                        text: TextSpan(children: [
                                        const TextSpan(
                                          text: 'End Date : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: requestData[index]['dueTime'],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ]))
                                    : Column(
                                        children: [
                                          SizedBox(height: 2),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'End Date : ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'not applicable',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                checkNullContarctor != 'null'
                                    ? RichText(
                                        text: TextSpan(children: [
                                        const TextSpan(
                                          text: 'Due Days : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: requestData[index]['dueDays'],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ]))
                                    : Column(
                                        children: [
                                          SizedBox(height: 2),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Due Days : ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'not applicable',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                SizedBox(height: 2),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Status : ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: requestData[index]['status'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ])),
                                SizedBox(height: 2),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Work Type : ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: requestData[index]['workType'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ])),
                                SizedBox(height: 2),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Description: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: requestData[index]['description'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ])),

                                SizedBox(height: 20),

                                checkNullContarctor == 'null'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Center(
                                            child: Text(
                                              'Wager Details',
                                              style: TextStyle(
                                                fontSize: 16.5,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 7),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                Wager_View_On_ID_Click
                                                    .routeName,
                                                arguments: {
                                                  'wagerID': requestData[index]
                                                      ['wagerID'],
                                                },
                                              );
                                            },
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: 'ID: ',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: requestData[index]
                                                        ['wagerID'],
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            const Center(
                                              child: Text(
                                                'Constructor Details',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                  Con_View_On_ID_Click
                                                      .routeName,
                                                  arguments: {
                                                    'constructorID':
                                                        requestData[index]
                                                            ['contractor'],
                                                  },
                                                );
                                              },
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: 'ID: ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: requestData[index]
                                                          ['contractor'],
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ])
                              ],
                            ),
                          ),
                        );
                      }));
                }),
          ),
        ],
      ),
    );
  }
}
