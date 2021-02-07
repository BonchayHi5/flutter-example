import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MaterialApp(
    // debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localAuth = LocalAuthentication();
  bool _hasFingerPrint = false;
  String authorNot = 'Not Authenticate';
  List<BiometricType> _availableBio = List<BiometricType>();

  Future<void> checkBioSupport() async {
    bool hasFingerPrint = false;

    try {
      hasFingerPrint = await localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _hasFingerPrint = hasFingerPrint;
    });
  }

  Future<void> getBioList() async {
    List<BiometricType> availableBio = List<BiometricType>();
    try {
      availableBio = await localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _availableBio = availableBio;
    });
  }

  Future<void> authenticate() async {
    bool authenticate = false;

    try {
      authenticate = await localAuth.authenticateWithBiometrics(
          localizedReason: 'Log In', useErrorDialogs: true, stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState(() {
      authorNot = authenticate ? 'Authenticated' : 'Not Authenticate ';
    });
  }

  Widget _btnLogin() {
    return Container(
      width: 150,
      height: 50,
      child: RaisedButton(
        onPressed: () {
          authenticate();
        },
        child: Text(
          "Fingerprint Auth",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
      ),
    );
  }

  @override
  void initState() {
    checkBioSupport();
    getBioList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _btnLogin(),
          Text('$_hasFingerPrint'),
          Text('$_availableBio'),
          SizedBox(
            height: 20,
          ),
          Text(authorNot)
        ],
      )),
    );
  }
}
