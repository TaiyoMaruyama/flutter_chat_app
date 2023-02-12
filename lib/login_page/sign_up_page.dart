import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../chat_page/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sigUpPage(),
    );
  }
}

class sigUpPage extends StatefulWidget {
  const sigUpPage({Key? key}) : super(key: key);

  @override
  State<sigUpPage> createState() => _sigUpPageState();
}

class _sigUpPageState extends State<sigUpPage> {
  String newUserEmail = '';
  String newUserPassword = '';
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ログイン画面',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'ようこそチャットルームへ！',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  '新規登録をして下さい',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'User Email',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      newUserEmail = value;
                    });
                  },
                ),
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'User Password',
                    prefixIcon: Icon(Icons.key_outlined),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      newUserPassword = value;
                    });
                  },
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  // メッセージ表示
                  child: Text(infoText),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: Text('新規登録'),
                  onPressed: () async {
                    try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.signInWithEmailAndPassword(
                        email: newUserEmail,
                        password: newUserPassword,
                      );
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return ChatMain();
                        }),
                      );
                    } catch (e) {
                      setState(() {
                        infoText = '登録に失敗しました：${e.toString()}';
                      });
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
