import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_data/auth_data_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthDataCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<AuthDataCubit, AuthDataState>(
        builder: (context, state) {
          if (state is AuthDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthDataLoaded) {
            if (state.currentUser != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome, ${state.currentUser.name}!'),
                    Text('Email: ${state.currentUser.email}'),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('User data not available.'));
            }
          } else if (state is AuthDataError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Please log in.'));
        },
      ),
    );
  }
}
