import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/1.engineer/layout/manager/engineer_layout_cubit.dart';

import '../../../shared/features/authentication/view/login_page.dart';

class EngineerLayout extends StatelessWidget {
  const EngineerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EngineerLayoutCubit(),
      child: BlocConsumer<EngineerLayoutCubit, EngineerLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          final EngineerLayoutCubit cubit = EngineerLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const CircleAvatar(),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const LoginPage()));

                  },
                  child: const Text('LogOut'),
                ),
              ],
            ),
            body: cubit.pages[cubit.page],
          );
        },
      ),
    );
  }
}
