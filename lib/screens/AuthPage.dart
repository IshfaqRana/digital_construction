import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_c_admin/screens/HomePage.dart';
import 'package:d_c_admin/screens/adminPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AuthPage extends StatefulWidget {
  static const routeName = '/auth-screen';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailContorller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  bool _obsCureText = true;

  void validateAndSubmitForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> admin =
        firestore.collection('Admin').snapshots();

    return StreamBuilder(
      stream: admin,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final adminCredentials = snapshot.requireData;

        return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final adminEmail = adminCredentials.docs[index]['Email'];
                    final adminPassword =
                        adminCredentials.docs[index]['Password'];

                    return Form(
                      key: formKey,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 375,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/background.png'),
                                      fit: BoxFit.fill)),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 30,
                                    width: 80,
                                    height: 200,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/light-1.png'))),
                                    ),
                                  ),
                                  Positioned(
                                    left: 140,
                                    width: 80,
                                    height: 150,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/light-2.png'))),
                                    ),
                                  ),
                                  Positioned(
                                    right: 40,
                                    top: 40,
                                    width: 80,
                                    height: 150,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/clock.png'))),
                                    ),
                                  ),
                                  Positioned(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 50),
                                      child: const Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  143, 148, 251, .2),
                                              blurRadius: 20.0,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey))),
                                          child: TextFormField(
                                            validator: (emailValue) {
                                              if (emailValue!.isEmpty) {
                                                return 'Provide a valid email';
                                              }
                                              if (emailValue != adminEmail) {
                                                return 'Invalid Email';
                                              }
                                              return null;
                                            },
                                            controller: emailContorller,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Email Address",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (passwordValue) {
                                              if (passwordValue!.isEmpty) {
                                                return 'Enter Password';
                                              }
                                              if (passwordValue !=
                                                  adminPassword) {
                                                return 'Invalid Password';
                                              }
                                              return null;
                                            },
                                            controller: passwordController,
                                            obscureText: _obsCureText,
                                            decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    _obsCureText =
                                                        !_obsCureText;
                                                    setState(() {});
                                                  },
                                                  child: Icon(_obsCureText
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                                ),
                                                border: InputBorder.none,
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      validateAndSubmitForm();
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blueAccent,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 70,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),
        );
      },
    );
  }
}
