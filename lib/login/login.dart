import 'package:flutter/material.dart';
import 'package:njawani/constant.dart';
import 'package:njawani/elemen/_roundedButton.dart';
import 'package:njawani/elemen/_textContainer.dart';
import 'package:njawani/home.dart';
import 'package:njawani/login/auth_method.dart';
import 'package:njawani/login/signup.dart';
import 'package:njawani/utils/utis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isobscure = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Yeay!'),
                content: Text('Berhasil Login'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text("Ok"))
                ],
              ));

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
                color: prblue,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80))),
            child: Center(
              child: Image.asset(
                'assets/img/logo.png',
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.65,
            color: prblue,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(80))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mlebu Akun',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  TextFieldContainer(
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: 'email',
                          border: InputBorder.none,
                          icon: Icon(Icons.mail)),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _isobscure,
                      decoration: InputDecoration(
                        hintText: 'password',
                        border: InputBorder.none,
                        icon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_isobscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isobscure = !_isobscure;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  RoundedButton(
                      child: !_isLoading
                          ? Text("Masuk")
                          : CircularProgressIndicator(),
                      press: loginUser),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum Punya Akun? ',
                        style: TextStyle(color: dark),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          ' Daftar',
                          style: TextStyle(
                              color: prblue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
