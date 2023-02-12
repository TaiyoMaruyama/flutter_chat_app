import 'package:familychatapp/login_page/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../chat_page/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String loginUserEmail = '';
  String loginUserPassword = '';
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                  '私たちのチャットルームへようこそ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 50),
                const Text(
                  'ログインして下さい',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  //email
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'User Email',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      loginUserEmail = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'User Password',
                    prefixIcon: Icon(Icons.key_outlined),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      loginUserPassword = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    child: Text('ログイン'),
                    onPressed: () async {
                      try {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final result = await auth.signInWithEmailAndPassword(
                          email: loginUserEmail,
                          password: loginUserPassword,
                        );
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) =>
                              ChatMain()
                          ),);
                      } catch (e) {
                        // ログインに失敗した場合z
                        setState(() {
                          infoText = "ログインに失敗しました：${e.toString()}";
                        });
                      }
                    }),
                SizedBox(height: 10),
                OutlinedButton(
                  child: Text('新規登録'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => sigUpPage()));
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
