import 'package:flutter/material.dart';

class DialogUtils {
  final GlobalKey key;

  DialogUtils(this.key);

  showExclusionDialog(BuildContext context, VoidCallback confirmCallback,
      VoidCallback cancelCallback) {
    showAlertConfirmationDialog(
        context,
        "Esta operação é irreversível, tem certeza que deseja excluir?",
        confirmCallback,
        cancelCallback);
  }

  showAlertConfirmationDialog(BuildContext context, String message,
      VoidCallback confirmCallback, VoidCallback cancelCallback) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Confirmar"),
      onPressed: () {
        hideDialog();
        confirmCallback();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        hideDialog();
        cancelCallback();
      },
    );
    AlertDialog alert = AlertDialog(
      key: key,
      title: Text("Atenção"),
      content: Text(message),
      actions: [
        okButton,
        cancelButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
    if (key != null && key.currentContext != null)
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
