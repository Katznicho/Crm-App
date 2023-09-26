import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({Key? key}) : super(key: key);

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments using ModalRoute
       final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      final String name = args["name"] ?? ""; // Get the "name" parameter
      final String index = args["index"] ?? ""; // Get the "index" parameter

      return Scaffold(
        appBar: AppBar(
          title: Text(name), // Render the "name" parameter in the AppBar title
        ),
        body: Center(
          child: Text(
              'Index: $index'), // Render the "index" parameter in the Text widget
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text('No arguments passed.'),
        ),
      );
    }
  }
}
