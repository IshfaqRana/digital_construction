import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class SmsSend extends StatefulWidget {
  const SmsSend({
    Key? key,
  }) : super(key: key);

  static const routeName = '/sms-send-page';

  @override
  State<SmsSend> createState() => _SmsSendState();
}

class _SmsSendState extends State<SmsSend> {
  String phoneArgs = '';
  late Color colorArgs;

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    phoneArgs = args['phone'];
    colorArgs = args['color'];
    recipientController.text = phoneArgs;
    setState(() {});
    super.didChangeDependencies();
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController recipientController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorArgs,
        elevation: 0.0,
        title: const Text('Send a SMS'),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled: false,
                keyboardType: TextInputType.phone,
                controller: recipientController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Add some message to send';
                  }
                  return null;
                },
                controller: messageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Message',
                ),
              ),
            ),
            sendSmsButton(context),
          ],
        ),
      ),
    );
  }

  FlatButton sendSmsButton(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.all(15),
      color: colorArgs,
      textColor: Colors.white,
      onPressed: () {
        if (!formKey.currentState!.validate()) {
          return;
        }
        SmsSender message = SmsSender();

        message.sendSms(
          SmsMessage(
            recipientController.text,
            messageController.text,
          ),
        );

        message.onSmsDelivered.listen((state) async {
          if (state.state == SmsMessageState.Sent) {
            print("SMS is sent!");

            await showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text("Sms is Sent"),
                  );
                }).then((_) => Future.delayed(const Duration(seconds: 1), () {
                  Navigator.of(context).pop();
                }));
          } else if (state.state == SmsMessageState.Fail) {
            print("SMS Failed!");

            await showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text("Sms Failed"),
                  );
                }).then((_) => Future.delayed(const Duration(seconds: 1), () {
                  Navigator.of(context).pop();
                }));
          }
        });
      },
      child: const Text('SEND SMS'),
    );
  }
}
