import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_bloc/Views/login.view.dart';
import 'package:socialmedia_bloc/bloc/google_sigin_bloc_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media Authentication'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<GoogleSiginCubit, dynamic>(builder: (context, state) {
            if (state is GoogleSiginBlocSuccessfulState) {
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginView())));
            }

            if (state is GoogleSiginLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: ElevatedButton(
                onPressed: () =>
                    BlocProvider.of<GoogleSiginCubit>(context).googleSigin(),
                child: const Text('Login'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
