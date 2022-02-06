import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:d_c_admin/screens/ViewUserRequestPage.dart';
import 'package:d_c_admin/screens/all_chat.dart';
import 'package:d_c_admin/screens/shopPage.dart';
import 'package:d_c_admin/widgets/ShopSearch.dart';
import 'package:d_c_admin/widgets/constructorSearch.dart';
import 'package:d_c_admin/widgets/wagerSearch.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 190,
            color: Colors.purple,
            child: SizedBox(
              width: 200.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 26.0,
                  fontFamily: 'Bobbers',
                ),
                child: Center(
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TyperAnimatedText(
                        'Hello Admin',
                        speed: const Duration(milliseconds: 150),
                      ),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(ConstructorSearch.routeName),
            child: const ListTile(
              leading: Icon(
                Icons.construction,
                color: Colors.purpleAccent,
              ),
              title: Text(
                'Search Constructors',
                style: TextStyle(
                  color: Color.fromARGB(255, 97, 92, 92),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(WagerSearch.routeName),
            child: const ListTile(
              leading: Icon(
                Icons.home_work_rounded,
                color: Colors.purpleAccent,
              ),
              title: Text(
                'Search Wagers',
                style: TextStyle(
                  color: Color.fromARGB(255, 97, 92, 92),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          //  const SizedBox(height: 13),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ShopSearch.routeName);
            },
            child: const ListTile(
              leading: Icon(
                Icons.shop,
                color: Colors.purpleAccent,
              ),
              title: Text(
                'Search Shops',
                style: TextStyle(
                  color: Color.fromARGB(255, 97, 92, 92),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          const Divider(),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(ViewUserRequestPage.routeName),
            child: const ListTile(
              leading: Icon(
                Icons.request_page,
                color: Colors.purpleAccent,
              ),
              title: Text(
                'View User Requests',
                style: TextStyle(
                  color: Color.fromARGB(255, 97, 92, 92),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          ListTile(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChatWithBarberLayout()));
            },
            leading: const Icon(Icons.all_inbox_sharp),
            title: const Text("Inbox"),
          ),
        ],
      ),
    );
  }
}
