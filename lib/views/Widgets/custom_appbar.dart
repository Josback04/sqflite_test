import 'package:flutter/material.dart';

class CustomAppbar extends AppBar {
  String titleString;
  String buttonTitle;
  VoidCallback callback;

  CustomAppbar(
      {required this.buttonTitle,
      required this.callback,
      required this.titleString})
      : super(title: Text(titleString), actions: [
          Builder(builder: (context) {
            return TextButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: callback,
                child: Text(
                  buttonTitle,
                  style: TextStyle(color: Colors.white),
                ));
          })
        ]);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
