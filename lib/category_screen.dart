import 'package:flutter/material.dart';

class CategotyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('The recipes'),
        ),
        body: Center(
          child: Text("The recipes of the category"),
        ));
  }
}
