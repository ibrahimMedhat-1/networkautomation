import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/1.engineer/features/browse_clients/manager/clients_cubit.dart';
import 'package:networkautomation/1.engineer/features/browse_clients/view/client_data_page.dart';
import 'package:networkautomation/shared/common_widgets/text_form_field.dart';

class EngineerHomePage extends StatelessWidget {
  const EngineerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientsCubit()..getAllClients(),
      child: BlocConsumer<ClientsCubit, ClientsState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          ClientsCubit cubit = ClientsCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                  child: Row(children: [
                    TextFormFieldCustom(
                      enabled: true,
                    ),
                  ]),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (builder) =>  ClientDataPage(
                                  userModel: cubit.clients[index],
                                )));
                          },
                          leading: cubit.clients[index].image==""? CircleAvatar(
                            backgroundColor: Colors.blue.shade800,
                            child: const Center(
                              child: Icon(Icons.person,color: Colors.white,),
                            ),
                          ):CircleAvatar(
                            backgroundImage: NetworkImage(cubit.clients[index].image.toString()),
                          ),
                          title:  Text(cubit.clients[index].name!),
                          trailing: const Icon(
                              Icons.arrow_forward_ios_outlined),
                        ),
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                    itemCount: cubit.clients.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
