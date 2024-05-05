import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../usuario/provider/user_controller.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isHidden = true;

  @override
  void initState() {
    email.text = "miftahulinc@gmail.com";
    password.text = "huda12345";
    super.initState();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void showSnackbar(BuildContext context, String text) {
    final snackBar = SnackBar(
        elevation: 6.0,
        backgroundColor: Color.fromARGB(255, 88, 87, 87),
        behavior: SnackBarBehavior.floating,
        content: Text(text),
        duration: const Duration(seconds: 5));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Web- protótipo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.people),
              ),
            ),
            TextField(
              controller: password,
              obscureText: _isHidden,
              decoration: InputDecoration(
                icon: const Icon(Icons.lock),
                labelText: "Senha",
                suffixIcon: IconButton(
                  onPressed: _togglePasswordView,
                  icon: Icon(
                    _isHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(userControllerProvider.notifier)
                          .login(
                            email: email.text,
                            password: password.text,
                          )
                          .then(
                            (res) => {
                              res.fold(
                                (l) => {
                                  showSnackbar(context, l),
                                },
                                (r) => {
                                  Navigator.pushReplacementNamed(
                                      context, 'Home'),
                                },
                              ),
                            },
                          );
                    },
                    child: const Text("Login"),
                  ),
                ),
              ],
            ),
            const Image(image: AssetImage('assets/images/logo.jpg')),
          ],
        ),
      ),
    );
  }
}
