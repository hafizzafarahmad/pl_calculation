import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_event.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_state.dart';
import 'package:pl_calculation/features/auth/presentation/pages/splash_screen_page.dart';
import 'package:pl_calculation/features/listResult/presentation/pages/list_result_page.dart';


import 'login_page.dart';

class IndexAuth extends StatefulWidget {
  @override
  _IndexAuth createState() => _IndexAuth();
}

class _IndexAuth extends State<IndexAuth> {

  @override
  void initState() {
    context.read<AuthBloc>().add(AppStarted(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print(state);
        if (state is AuthInitialized) {
          return SplashScreenPage();

        } else if (state is Unauthenticated) {
          return LoginPage();

        } else if (state is Authenticated) {
          return ListResultPage();

        } else {
          return LoginPage();
        }
      },
    );
  }

}
