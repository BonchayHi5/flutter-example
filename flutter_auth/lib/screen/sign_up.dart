import 'package:flutter/material.dart';
import 'package:flutter_auth/core/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

     

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
                      Text('Sign Up', style: TextStyle(fontSize: 22)),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: 'Email'),
                        validator: (value) =>
                            value.isEmpty ? 'Please fill in email' : null,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: 'Password'),
                        validator: (value) =>
                            value.isEmpty ? 'Please fill in password' : null,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: onSubmit,
                          child: Text('Sign Up'),
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
