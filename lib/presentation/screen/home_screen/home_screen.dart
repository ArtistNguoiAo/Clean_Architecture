import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:risky_coin/presentation/screen/home_screen/cubit/home_cubit.dart';
import 'package:risky_coin/presentation/utils/color_utils.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..init(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is HomeError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if(state is HomeLoading){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            body: SafeArea(
              child: _body(context),
            ),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      color: ColorUtils.primaryColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        child: const Text('Logout'),
        onPressed: () {
          AutoRouter.of(context).pop();
        },
      ),
    );
  }
}
