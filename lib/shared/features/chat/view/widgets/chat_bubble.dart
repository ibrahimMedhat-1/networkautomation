import 'package:flutter/material.dart';

import '../../../../../shared/styles/colors.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            const Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: CircleAvatar(
                backgroundColor: ColorsAsset.mainColor,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width + 0.7),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: isUser ? Colors.black87 : ColorsAsset.mainColor,
                    borderRadius: !isUser
                        ? const BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )
                        : const BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          )),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          if (isUser)
            const Padding(
              padding: EdgeInsets.only(bottom: 40.0, left: 5),
              child: CircleAvatar(
                backgroundColor: ColorsAsset.mainColor,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }
}
