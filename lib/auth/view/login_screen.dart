import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop_bags/auth/view/sign_up_screen.dart';
import 'package:shop_bags/shop/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowpassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'welcome'.toUpperCase(),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const FlutterLogo(size: 200),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Enter username or Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: isShowpassword,
                decoration: InputDecoration(
                    suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            isShowpassword = !isShowpassword;
                          });
                        },
                        child: Icon(isShowpassword
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    hintText: 'Enter password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            CupertinoButton(
              color: Colors.blue,
              child: const Text('Login'),
              onPressed: () async {
                final credential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                if (credential != null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (route) => false);
                }
              },
            )
          ],
        ),
      )),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ));
              },
              child: const Text('Register Account'))
        ],
      ),
    );
  }
}
