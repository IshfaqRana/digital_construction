import 'package:d_c_admin/screens/AuthPage.dart';
import 'package:d_c_admin/screens/ConstructorPage.dart';
import 'package:d_c_admin/screens/EmailTempConPage.dart';
import 'package:d_c_admin/screens/EmailTempShopPage.dart';
import 'package:d_c_admin/screens/EmailTempWagPage.dart';
import 'package:d_c_admin/screens/HomePage.dart';
import 'package:d_c_admin/screens/ViewUserRequestPage.dart';
import 'package:d_c_admin/screens/WagerPage.dart';
import 'package:d_c_admin/screens/adminPage.dart';
import 'package:d_c_admin/screens/shopPage.dart';
import 'package:d_c_admin/screens/smsPage.dart';
import 'package:d_c_admin/widgets/Con_View_On_ID_Click.dart';
import 'package:d_c_admin/widgets/ShopSearch.dart';
import 'package:d_c_admin/widgets/Wager_View_On_ID_Click.dart';
import 'package:d_c_admin/widgets/constructorSearch.dart';
import 'package:d_c_admin/widgets/emailTempConPageAfterSearch.dart';
import 'package:d_c_admin/widgets/emailTempShopPageAfterSearch.dart';
import 'package:d_c_admin/widgets/emailTempWagPageAfterSearch.dart';
import 'package:d_c_admin/widgets/wagerSearch.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'api/models/helpers.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Helper.fetchAllCons();
  Helper.fetchAllUsers();
  Helper.fetchAllWagers();
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        ConstructorPage.routeName: (_) => const ConstructorPage(),
        WagerPage.routeName: (_) => const WagerPage(),
        AdminPage.routeName: (_) => const AdminPage(),
        AuthPage.routeName: (_) => AuthPage(),
        EmailTempConPage.routeName: (_) => EmailTempConPage(),
        EmailTempWagPage.routeName: (_) => EmailTempWagPage(),
        WagerSearch.routeName: (_) => const WagerSearch(),
        ConstructorSearch.routeName: (_) => const ConstructorSearch(),
        EmailTempConPageAfterSearch.routeName: (_) =>
            EmailTempConPageAfterSearch(),
        SmsSend.routeName: (_) => const SmsSend(),
        EmailTempWagPageAfterSearch.routeName: (_) =>
            EmailTempWagPageAfterSearch(),
        EmailTempShopPageAfterSearch.routeName: (_) =>
            EmailTempShopPageAfterSearch(),
        ShopPage.routeName: (_) => const ShopPage(),
        ShopSearch.routeName: (_) => const ShopSearch(),
        EmailTempShopPage.routeName: (_) => EmailTempShopPage(),
        ViewUserRequestPage.routeName: (_) => const ViewUserRequestPage(),
        Wager_View_On_ID_Click.routeName: (_) => const Wager_View_On_ID_Click(),
        Con_View_On_ID_Click.routeName: (_) => const Con_View_On_ID_Click(),
      },

      //    home: const HomePage(),

      home: AuthPage(),
    );
  }
}
