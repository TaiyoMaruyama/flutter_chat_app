import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String massageText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('投稿画面です'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'ここにメッセージを入力して下さい'),
              maxLength: 30,
              onChanged: (String value) {
                setState(() {
                  massageText = value;
                });
              },
            ),
            ElevatedButton(
                child: Text('投稿'),
                onPressed: () async {
                  final date = DateTime.now().toLocal().toIso8601String();
                  await FirebaseFirestore.instance
                      .collection('post')
                      .doc()
                      .set({'text': massageText, 'date': date});
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
