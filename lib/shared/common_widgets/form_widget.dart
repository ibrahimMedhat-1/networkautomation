import 'package:flutter/material.dart';
import 'package:networkautomation/shared/common_widgets/text_form_field.dart';
import 'package:networkautomation/shared/styles/colors.dart';

class FormWidget extends StatelessWidget {
  final bool isEngineer;
  const FormWidget({this.isEngineer = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business Title',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Row(children: [TextFormFieldCustom()]),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'How many floors are there ?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(width: 10),
              const TextFormFieldCustom(),
              const SizedBox(width: 10),
              Text(
                'Rooms',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(width: 10),
              const TextFormFieldCustom(),
              const SizedBox(width: 10),
              Text(
                'Desks',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(width: 10),
              const TextFormFieldCustom(),
              const SizedBox(width: 10),
              Text(
                'Computers',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(width: 10),
              const TextFormFieldCustom(),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Operating system type',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  items: [
                    DropdownMenuItem(
                      value: 'Windows',
                      child: Text(
                        'Windows',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  ],
                  onChanged: (value) {},
                  value: 'Windows',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: MaterialButton(
              height: 50,
              minWidth: 200,
              color: ColorsAsset.mainColor,
              textColor: Colors.white,
              onPressed: () {},
              child: isEngineer ? const Text('Get Python Code Configuration') : const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
