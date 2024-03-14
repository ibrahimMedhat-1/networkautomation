import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/user_layout_cubit.dart';

class UserLayout extends StatelessWidget {
  const UserLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLayoutCubit(),
      child: BlocConsumer<UserLayoutCubit, UserLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          final UserLayoutCubit cubit = UserLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const CircleAvatar(),
              actions: [
                TextButton(
                    onPressed: () {
                      cubit.changePage(0);
                    },
                    child: const Text('Home')),
                TextButton(
                    onPressed: () {
                      cubit.changePage(1);
                    },
                    child: const Text('Chat with Engineer')),
                TextButton(onPressed: () {}, child: const Text('Logout')),
              ],
            ),
            body: cubit.pages[cubit.page],
          );
        },
      ),
    );
  }
}
