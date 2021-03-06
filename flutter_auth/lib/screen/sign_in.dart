import 'package:flutter/material.dart';
import 'package:flutter_auth/core/auth.dart';
import 'package:flutter_auth/core/dialog.dart';
import 'package:flutter_auth/screen/home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = Auth();

  final _signUpKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void isValidate() {
    if (_signUpKey.currentState.validate()) {
      onSubmit();
    }
  }

  void onSubmit() async {
    setState(() {
      _isLoading = true;
    });

    final res =
        await _auth.signIn(_emailController.text, _passwordController.text);

    if (res != null) {
      setState(() {
        _isLoading = false;
      });

      if (res['error'] != null) {
        await dialog(context, 'Error', res['error']['message']);
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Home(res['email'])));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Container(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _signUpKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Sign In', style: TextStyle(fontSize: 22)),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: 'Email'),
                        validator: (value) =>
                            value.isEmpty ? 'Please fill in email' : null,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: 'Password'),
                        validator: (value) => value.isEmpty || value.length < 6
                            ? 'Please fill in 6 characters password'
                            : null,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: isValidate,
                          child: Text('Sign In'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
