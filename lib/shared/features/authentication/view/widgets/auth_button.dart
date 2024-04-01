import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  const AuthButton({
    super.key,
    required this.onTap(),
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: MaterialButton(
        padding: const EdgeInsets.all(20),
        onPressed: () async {
          onTap();
        },
        elevation: 3,
        color: Colors.blueAccent,
        textColor: Colors.white,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
