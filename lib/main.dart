import 'package:flutter/material.dart';
import 'package:it_client/app/ui/main_app_builder.dart';
import 'package:it_client/app/ui/main_app_runner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const env = String.fromEnvironment("env", defaultValue: "dev");
  const runner = MainAppRunner(env);
  final builder = MainAppBuilder();
  runner.run(builder);
}
