// ignore_for_file: file_names

import 'package:d_c_admin/screens/AuthPage.dart';
import 'package:d_c_admin/screens/ConstructorPage.dart';
import 'package:d_c_admin/screens/WagerPage.dart';
import 'package:d_c_admin/screens/shopPage.dart';
import 'package:d_c_admin/widgets/custom-drawer.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);
  static const routeName = '/admin-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
        title: const Text('Admin Panel'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150),
          ),
          color: Colors.pink,
          elevation: 7,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: Colors.purple,
            elevation: 11,
            child: Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.all(13),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 13,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ConstructorPage.routeName);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          color: Colors.red,
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.construction,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Pending Contructors',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(WagerPage.routeName);
                        },
                        child: Container(
                          width: 250,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(13),
                          color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.work,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Pending Wagers',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(ShopPage.routeName);
                        },
                        child: Container(
                          width: 250,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(13),
                          color: Colors.purple,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.work,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Pending Shops',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
