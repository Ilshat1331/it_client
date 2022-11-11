import 'package:it_client/app/ui/main_app_builder.dart';
import 'package:it_client/app/ui/main_app_runner.dart';

void main() {
  final runner = MainAppRunner();
  final builder = MainAppBuilder();
  runner.run(builder);
}
