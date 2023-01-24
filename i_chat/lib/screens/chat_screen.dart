import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_chat/widgets/chat/message_input.dart';
import 'package:i_chat/widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  final _collectionPath = 'chats/u5VyLZu9Xy4U08FUvQLq/messages';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Flutter Chat',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                  value: 'logout',
                  child: Row(children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text('Logout')
                  ]))
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.9],
            colors: [
              Color.fromRGBO(51, 58, 67, 1),
              Color.fromRGBO(24, 28, 31, 1),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(child: Messages()),
            MessageInput(),
          ],
        ),
      ),
      // StreamBuilder(
      //   stream:
      //       FirebaseFirestore.instance.collection(_collectionPath).snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     final documents = snapshot.data?.docs;
      //     return ListView.builder(
      //       itemCount: documents!.length,
      //       itemBuilder: (ctx, index) {
      //         var item = documents.elementAt(index);
      //         return Container(
      //           padding: const EdgeInsets.all(8),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(item['text']),
      //               Text(
      //                 (item['created_at'] as Timestamp)
      //                     .toDate()
      //                     .toIso8601String(),
      //               )
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     FirebaseFirestore.instance.collection(_collectionPath).add(
      //         {'text': 'Message number 10', 'created_at': Timestamp.now()});
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
