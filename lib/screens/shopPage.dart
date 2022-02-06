// ignore_for_file: deprecated_member_use, prefer_const_constructors
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_c_admin/screens/EmailTempWagPage.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/shop-page';

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> shops =
        fireStore.collection('Shops').snapshots();

    return Scaffold(
      backgroundColor: Colors.white54,
      body: StreamBuilder(
        stream: shops,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          final shopData = snapshot.requireData;

          List<DocumentSnapshot> shopDataNotApproved = [];

          shopData.docs.forEach((element) {
            if (element['isShopApproved'] == false) {
              shopDataNotApproved.add(element);
            }
          });

          if (shopDataNotApproved.isEmpty) {
            return Center(
                child: Text(
              'No Pending Data',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ));
          }

          return ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  width: 0,
                  height: 0,
                );
              },
              itemCount: shopDataNotApproved.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                child: Image.network(
                                  shopDataNotApproved[index]['shopImage'],
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
                                    shopDataNotApproved[index]['shopImage'],
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
                                  text: 'Shop Name: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: shopDataNotApproved[index]['shopName'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Owner Name: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: shopDataNotApproved[index]
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
                                  text: shopDataNotApproved[index]
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
                                text: shopDataNotApproved[index]
                                        ['shopOwnerPhoneNo']
                                    .toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )),
                          const SizedBox(height: 5),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FlatButton(
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('Shops')
                                        .doc(shopDataNotApproved[index].id)
                                        .update({'isShopApproved': true});
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
                                                    shopDataNotApproved[index]
                                                        .id);
                                                FirebaseFirestore.instance
                                                    .collection('Shops')
                                                    .doc(shopDataNotApproved[
                                                            index]
                                                        .id)
                                                    .delete();

                                                Navigator.of(context).pushNamed(
                                                  EmailTempWagPage.routeName,
                                                  arguments: shopData
                                                          .docs[index]
                                                      ['shopOwnerEmailName'],
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
