import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/shared/features/chat/view/widgets/chat_bubble.dart';

import '../../../../models/message_model.dart';
import '../../../../shared/styles/colors.dart';
import '../../../constants.dart';
import '../manager/chat_cubit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          final ChatCubit cubit = ChatCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Column(
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
                          isUser: message.senderId == 'client' ? true : false,
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
                                receiverId: '',
                                senderId: Constants.userModel!.id,
                              );
                              // cubit.sendMessage(message);
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
            ),
          );
        },
      ),
    );
  }
}
