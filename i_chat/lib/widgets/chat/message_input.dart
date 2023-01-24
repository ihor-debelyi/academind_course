import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  MessageInput({Key? key}) : super(key: key);

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;
    var collection = FirebaseFirestore.instance.collection('chat');
    collection.add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
    });
    _enteredMessage = '';
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(label: Text('Send a message...')),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          ),
        ),
        IconButton(
          onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          color: Theme.of(context).colorScheme.secondary,
          icon: const Icon(Icons.send),
        ),
      ]),
    );
  }
}
