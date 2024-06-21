import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/2.user/features/home_page/manager/user_home_cubit.dart';
import 'package:networkautomation/shared/constants.dart';

import '../../../../shared/common_widgets/form_widget.dart';
import '../../../payment/view/payment_page.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeCubit()
        ..initialize()
        ..listenToStepsChanges(),
      child: BlocConsumer<UserHomeCubit, UserHomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          int activeStep = Constants.userModel!.steps == null ? 0 : Constants.userModel!.steps!;

          UserHomeCubit cubit = UserHomeCubit.get(context);
          return SingleChildScrollView(
            child: Column(
              children: [
                Stepper(
                  onStepTapped: (step) {},
                  currentStep: activeStep,
                  controlsBuilder: (context, details) => const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(),
                  ),
                  steps: [
                    Step(
                      isActive: activeStep == 0,
                      title: const Text('Please Submit your form'),
                      content: const SizedBox(),
                    ),
                    Step(
                      isActive: activeStep == 1,
                      title: const Text('Reviewing your form'),
                      content: const SizedBox(),
                    ),
                    Step(
                      isActive: activeStep == 2,
                      title: const Text('Implementing your network'),
                      content: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('price: ${Constants.userModel!.price.toString()}'),
                            MaterialButton(
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentPage(
                                        totalAmount: Constants.userModel!.price.toString(),
                                      ),
                                    ));
                              },
                              child: const Text('Pay'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Step(
                      isActive: activeStep == 3,
                      title: const Text('Delivering your network file'),
                      content: const SizedBox(),
                    ),
                    Step(
                      state: StepState.complete,
                      isActive: activeStep == 4,
                      title: const Text('Done'),
                      content: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            window.open(cubit.pdfUrl!, '');
                          },
                          child: const Text('Download your file'),
                        ),
                      ),
                    ),
                  ],
                ),
                FormWidget(
                  onPressed: () {
                    cubit.uploadData();
                  },
                  buisnessTitleController: cubit.buissnessTitleController,
                  computersController: cubit.computersController,
                  desksController: cubit.desksController,
                  floorsController: cubit.floorsController,
                  roomsController: cubit.roomsController,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
