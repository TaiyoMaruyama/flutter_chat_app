import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login_page/login_page.dart';
import 'add_post.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class ChatMain extends StatefulWidget {
  @override
  State<ChatMain> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('チャット'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout_sharp,
              size: 30,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        width: 350,
        backgroundColor: Colors.white,
        elevation: 0,
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.account_box),
                    Text('assasfadfad'),
                  ],
                ),
                SizedBox(height: 10),
                Text('ようこそ！私たちのチャットルームへ！'),
              ],
            )),
            ListTile(
              title: Text('リスト1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('リスト2'),
              onTap: () {},
            ),
            ListTile(
              title: Text('リスト3'),
              onTap: () {},
            ),
            ListTile(
              title: Text('リスト4'),
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddPostPage();
            }),
          );
        },
      ),
      body: Column(
        children: [
          Container(
            child: Text('みんなのチャットです'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('post')
                  .orderBy('date')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: ListTile(
                          title: Text(document['text']),
                        ),
                      );
                    }).toList(),
                  );
                }
                return Center(
                  child: Text('読込中...'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
