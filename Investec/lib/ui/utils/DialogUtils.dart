import 'package:flutter/material.dart';

class DialogUtils {
  final GlobalKey key;

  DialogUtils(this.key);

  showAlertDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        hideDialog();
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      key: key,
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void hideDialog() {
    Navigator.of(key.currentContext, rootNavigator: true).pop();
  }

  Future<void> showLoadingDialog(BuildContext context,
      {String message = ""}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(key: key, children: <Widget>[
                Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      message,
                    )
                  ]),
                )
              ]));
        });
  }
}
