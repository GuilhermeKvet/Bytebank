import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String? _message;

  ErrorView(this._message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Progressing"),
        ),
        body: Text(_message!));
  }
}

// _showFailureMessage(BuildContext context, String message) {
//   // final snackBar = SnackBar(content: Text(message));
//   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   // messageDialog(context, message);
//   // showToast(message, gravity: Toast.bottom);
//   return showDialog(
//     context: context,
//     builder: (_) => NetworkGiffyDialog(
//       image: Image.asset('images/error.gif'),
//       title: const Text('Ops',
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
//       description: Text(message, textAlign: TextAlign.center),
//       entryAnimation: EntryAnimation.TOP,
//       onOkButtonPressed: () {
//         // Navigator.pop(context);
//       },
//     ),
//   );
// }

// void showToast(String msg, {int? duration = 5, int? gravity}) {
//   Toast.show(msg, duration: duration, gravity: gravity);
// }