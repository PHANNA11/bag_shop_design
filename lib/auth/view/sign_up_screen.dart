import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
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
                'Create Account'.toUpperCase(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: cpasswordController,
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
                      hintText: 'Enter confirm-password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              CupertinoButton(
                color: Colors.blue,
                child: const Text('Create'),
                onPressed: () async {
                  if (emailController.text.isNotEmpty ||
                      passwordController.text.isNotEmpty ||
                      cpasswordController.text.isNotEmpty) {
                    if (passwordController.text == cpasswordController.text) {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                      if (credential != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(' Back'))
        ],
      ),
    );
  }
}
