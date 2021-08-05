import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:pl_calculation/dependency_injection.dart' as di;
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pl_calculation/features/auth/presentation/pages/index_auth.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_bloc.dart';
import 'package:pl_calculation/features/result/domain/entities/result_entity.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_bloc.dart';

import 'core/platform/colors.dart';
import 'dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var appDockumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDockumentDirectory.path);
  Hive.registerAdapter(CalculateEntityAdapter());
  Hive.registerAdapter(ResultEntityAdapter());
  Hive.registerAdapter(ListResultEntityAdapter());

  await di.init();

  runApp(AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (BuildContext context) => sl<AuthBloc>()),
          BlocProvider<ListResultBloc>(create: (BuildContext context) => sl<ListResultBloc>()),
          BlocProvider<ResultBloc>(create: (BuildContext context) => sl<ResultBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Engine Calculation',
          theme: ThemeData(
            primaryColor: Pigment.fromString(PRIMARY_COLOR),
            accentColor: Pigment.fromString(PRIMARY_COLOR),
            fontFamily: 'Poppins',
          ),
          home: IndexAuth(),
        ));
  }
}
