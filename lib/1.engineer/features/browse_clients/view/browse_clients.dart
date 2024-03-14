import 'package:flutter/material.dart';
import 'package:networkautomation/1.engineer/features/browse_clients/view/client_data_page.dart';
import 'package:networkautomation/shared/common_widgets/text_form_field.dart';

class EngineerHomePage extends StatelessWidget {
  const EngineerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
            child: Row(children: [
              TextFormFieldCustom(),
            ]),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => const ClientDataPage()));
                },
                leading: const CircleAvatar(),
                title: const Text("Karim"),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: 40,
            ),
          ),
        ],
      ),
    );
  }
}
