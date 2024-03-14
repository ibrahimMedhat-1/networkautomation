import 'package:flutter/material.dart';

import '../../../../shared/common_widgets/form_widget.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stepper(
            onStepTapped: null,
            currentStep: 4,
            controlsBuilder: (context, details) => const Align(alignment: Alignment.centerLeft, child: SizedBox()),
            steps: [
              const Step(title: Text('Reviewing you form'), content: SizedBox()),
              const Step(title: Text('Reviewing your form'), content: SizedBox()),
              const Step(title: Text('Implementing your network'), content: SizedBox()),
              const Step(title: Text('Delivering your network file '), content: SizedBox()),
              Step(
                  state: StepState.complete,
                  isActive: true,
                  title: const Text('done'),
                  content: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Download your file'),
                    ),
                  )),
            ],
          ),
          const FormWidget(),
        ],
      ),
    );
  }
}
