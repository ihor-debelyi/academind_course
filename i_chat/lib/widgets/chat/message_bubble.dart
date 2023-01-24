import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.userId, this.isUserMessage, {Key? key})
      : super(key: key);
  final String message;
  final String userId;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isUserMessage
                ? Theme.of(context).colorScheme.secondary
                : const Color(0xFF4C565E),
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(10),
              topLeft: const Radius.circular(10),
              bottomLeft: isUserMessage
                  ? const Radius.circular(10)
                  : const Radius.circular(0),
              bottomRight: isUserMessage
                  ? const Radius.circular(0)
                  : const Radius.circular(10),
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: isUserMessage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Text(
                      userSnapshot.data!['username'],
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade300,
                        fontSize: 10,
                      ),
                    );
                  }),
              Text(
                message,
                // style: TextStyle(color: Theme.of(context).textTheme.headline1!.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
