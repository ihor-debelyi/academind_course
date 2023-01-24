import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> message = chatDocs[index].data();
              return MessageBubble(
                message['text'],
                message['userId'],
                user.uid == message['userId'],
                key: ValueKey(chatDocs[index].id),
              );
            });
      },
    );
  }
}
