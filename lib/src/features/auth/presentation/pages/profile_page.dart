import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/features/auth/presentation/bloc/auth_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            if (state.user != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome, ${state.user!.name}!'),
                    Text('Email: ${state.user!.email}'),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('User data not available.'));
            }
          } else if (state is AuthError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Please log in.'));
        },
      ),
    );
  }
}