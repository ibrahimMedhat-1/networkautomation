import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/1.engineer/features/browse_clients/manager/manager/clients_data_cubit.dart';
import 'package:networkautomation/models/user_model.dart';
import 'package:networkautomation/shared/common_widgets/form_widget.dart';
import 'package:networkautomation/shared/common_widgets/text_form_field.dart';
import 'package:networkautomation/shared/features/chat/view/chat_page.dart';

class ClientDataPage extends StatefulWidget {
  final UserModel userModel;

  const ClientDataPage({super.key, required this.userModel});

  @override
  State<ClientDataPage> createState() => _ClientDataPageState();
}

class _ClientDataPageState extends State<ClientDataPage> {
  TextEditingController computersController = TextEditingController();

  TextEditingController floorsController = TextEditingController();

  TextEditingController roomsController = TextEditingController();

  TextEditingController desksController = TextEditingController();

  TextEditingController buissnessTitleController = TextEditingController();

  bool isDataAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    computersController.text = widget.userModel.computers!;
    floorsController.text = widget.userModel.floors!;
    roomsController.text = widget.userModel.rooms!;
    desksController.text = widget.userModel.desks!;
    buissnessTitleController.text = widget.userModel.buisnessTitle!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientsDataCubit(),
      child: BlocConsumer<ClientsDataCubit, ClientsDataState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          ClientsDataCubit cubit = ClientsDataCubit.get(context);
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
                          widget.userModel.image == ""
                              ? CircleAvatar(
                                  radius: 120,
                                  backgroundColor: Colors.blue.shade800,
                                  child: const Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 120,
                                  backgroundImage: NetworkImage(widget.userModel.image.toString()),
                                ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.userModel.name!,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 30),
                                ),
                                Text(
                                  buissnessTitleController.text,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => ChatPage(
                                            chatUserModel: widget.userModel,
                                          )));
                            },
                            child: const Text(
                              'Chat',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FormWidget(
                      isEngineer: true,
                      onPressed: () {
                        print(widget.userModel.id!);
                        print(widget.userModel.steps!);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Set Price'),
                            content: TextFormFieldCustom(
                              controller: cubit.priceController,
                              enabled: true,
                            ),
                            actions: [
                              MaterialButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () async {
                                  cubit.setStep(context, widget.userModel.id!).then((value) {
                                    Navigator.pop(context);
                                  });
                                },
                                child: cubit.isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text('Continue'),
                              )
                            ],
                          ),
                        );
                      },
                      roomsController: roomsController,
                      floorsController: floorsController,
                      desksController: desksController,
                      computersController: computersController,
                      buisnessTitleController: buissnessTitleController,
                    ),
                    MaterialButton(
                      height: 100,
                      minWidth: double.infinity,
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        cubit.pickAndUploadPdf(widget.userModel.id!);
                      },
                      child: cubit.isUploading
                          ? const CircularProgressIndicator()
                          : const Text('Upload Network File'),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
