import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

class EmailTempWagPage extends StatefulWidget {
  @override
  _EmailTempWagPageState createState() => _EmailTempWagPageState();

  static const routeName = '/email-temp-wag-page';
}

class _EmailTempWagPageState extends State<EmailTempWagPage> {
  List<String> attachments = [];
  bool isHTML = false;

  TextEditingController _recipientController = TextEditingController();

  final _subjectController = TextEditingController(
    text: 'Rejection of your wager account\ncreation request.',
  );

  final _bodyController = TextEditingController(
    text: 'Specify Rejection Reason Here...',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final String emailRouteArgs;

  @override
  void dispose() {
    _bodyController.dispose();
    _recipientController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    emailRouteArgs = ModalRoute.of(context)!.settings.arguments as String;
    _recipientController = TextEditingController(
      text: emailRouteArgs,
    );
    super.didChangeDependencies();
  }

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: const Text('Rejection Email'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: <Widget>[
                  for (var i = 0; i < attachments.length; i++)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                            flex: 0,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 100,
                              height: 100,
                              child: Image.file(File(attachments[i]),
                                  fit: BoxFit.cover),
                            )),
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => {_removeAttachment(i)},
                        )
                      ],
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FlatButton.icon(
                            padding: const EdgeInsets.all(6.5),
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {
                              _openImagePicker();
                            },
                            icon: const Icon(Icons.attach_file),
                            label: const Text('Attach File (Optional...) '))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _openImagePicker() async {
    final pick = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }
}
