import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:it_client/app/di/init_di.dart';
import 'package:it_client/app/domain/app_builder.dart';
import 'package:it_client/app/domain/app_runner.dart';
import 'package:path_provider/path_provider.dart';

class MainAppRunner implements AppRunner {
  final String env;

  const MainAppRunner(this.env);

  @override
  Future<void> preloadData() async {
    // init app
    initDi(env);
    // init config
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
    );
    // HydratedBloc.storage = await HydratedStorage.build(
    //     storageDirectory: await getApplicationDocumentsDirectory());
    await preloadData();
    runApp(appBuilder.buildApp());
  }
}
