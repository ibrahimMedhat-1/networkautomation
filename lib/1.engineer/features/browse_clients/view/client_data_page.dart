import 'package:flutter/material.dart';
import 'package:networkautomation/shared/common_widgets/form_widget.dart';
import 'package:networkautomation/shared/features/chat/view/chat_page.dart';

class ClientDataPage extends StatelessWidget {
  const ClientDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 120,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Karim",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 30),
                          ),
                          Text(
                            'Business Name',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => const ChatPage()));
                      },
                      child: const Text(
                        'Chat',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              const FormWidget(isEngineer: true),
              MaterialButton(
                height: 100,
                minWidth: double.infinity,
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {},
                child: const Text('Upload Network File'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
