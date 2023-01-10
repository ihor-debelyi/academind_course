import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  final _collectionPath = 'chats/u5VyLZu9Xy4U08FUvQLq/messages';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection(_collectionPath).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data?.docs;
          return ListView.builder(
            itemCount: documents!.length,
            itemBuilder: (ctx, index) {
              var item = documents.elementAt(index);
              return Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['text']),
                    Text(
                      (item['created_at'] as Timestamp)
                          .toDate()
                          .toIso8601String(),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance.collection(_collectionPath).add(
                {'text': 'Message number 10', 'created_at': Timestamp.now()});
          },
          child: const Icon(Icons.add)),
    );
  }
}
