import 'package:d_c_admin/screens/AuthPage.dart';
import 'package:d_c_admin/screens/ConstructorPage.dart';
import 'package:d_c_admin/screens/WagerPage.dart';
import 'package:d_c_admin/screens/adminPage.dart';
import 'package:d_c_admin/screens/shopPage.dart';
import 'package:d_c_admin/screens/w2.dart';

import 'package:d_c_admin/widgets/constructorSearch.dart';
import 'package:d_c_admin/widgets/custom-drawer.dart';
import 'package:d_c_admin/widgets/search.dart';
import 'package:d_c_admin/widgets/wagerSearch.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
            },
            icon: const Icon(Icons.logout),
          )
        ],
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Construction Pal',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.purple.withOpacity(0.95),
        bottom: TabBar(
            labelPadding: const EdgeInsets.all(12),
            indicatorColor: Colors.white,
            isScrollable: true,
            controller: tabController,
            tabs: const [
              Text(
                'Pending Constructors',
                softWrap: false,
              ),
              Text('Pending Wagers'),
              Text('Pending Shops'),
            ]),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          ConstructorPage(),
          WagerPage(),
          ShopPage(),
        ],
      ),
    );
  }
}
