import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/app/app_bloc_observer.dart';
import 'package:flutter_project_template/app/app_router.dart';
import 'package:flutter_project_template/repository/local_repository.dart';
import 'package:flutter_project_template/repository/mock_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await LocalRepository().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MockRepository(),
      child: MaterialApp.router(
        routerConfig: AppRouter.config,
      ),
    );
  }
}
