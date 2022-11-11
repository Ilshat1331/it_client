import 'package:flutter/material.dart';
import 'package:it_client/app/domain/app_builder.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Text"),
        ),
      ),
    );
  }
}
