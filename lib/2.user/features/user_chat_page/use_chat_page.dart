
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/models/eng_model.dart';

import '../../../models/message_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/features/chat/view/widgets/chat_bubble.dart';
import '../../../shared/styles/colors.dart';
import 'manager/user_chat_cubit.dart';

class UserChatPage extends StatelessWidget {
  final EngModel engModel;

  const UserChatPage({
    super.key,
    required this.engModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserChatCubit()..getMessages(engModel.id),
      child: BlocConsumer<UserChatCubit, UserChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          final UserChatCubit cubit = UserChatCubit.get(context);
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/Green Minimalist World Earth Day Instagram Story (14).png')),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(engModel.name!),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: cubit.scrollController,
                        itemCount: cubit.reversedChatMessage.length,
                        itemBuilder: (context, index) {
                          final message = cubit.reversedChatMessage[index];
                          return ChatBubble(
                            text: message.text!,
                            isUser: message.senderId == Constants.userModel!.id ? true : false,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          controller: cubit.messageController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Send Message",
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            suffixIcon: IconButton(
                              onPressed: () {
                                MessageModel message = MessageModel(
                                  date: DateTime.now().toString(),
                                  text: cubit.messageController.text,
                                  sender: Constants.userModel!.name,
                                  receiverId: engModel.id,
                                  senderId: Constants.userModel!.id,
                                );
                                cubit.sendMessage(message);
                                cubit.messageController.clear();
                              },
                              icon: const Icon(Icons.send),
                            ),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: ColorsAsset.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
