import 'package:flutter/material.dart';
import 'package:njawani/constant.dart';
import 'package:njawani/elemen/_roundedButton.dart';
import 'package:njawani/elemen/_textContainer.dart';
import 'package:njawani/login/auth_method.dart';
import 'package:njawani/login/login.dart';
import 'package:njawani/utils/utis.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isobscure = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUp() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      nama: _namaController.text,
    );
    // if string returned is sucess, user has been created
    if (res == "sukses sign up") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Yeay'),
                content: Text(
                    'Akun berhasil dibuat, lanjut dengan login ke akun Anda?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                      child: Text('Tidak')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Ok');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text('Iya')),
                ],
              ));
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
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
                    'Gawe Akun',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  TextFieldContainer(
                    child: TextField(
                      controller: _namaController,
                      decoration: InputDecoration(
                          hintText: 'namamu',
                          border: InputBorder.none,
                          icon: Icon(Icons.person)),
                    ),
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
                      obscureText: _isobscure,
                      controller: _passwordController,
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
                      press: signUp),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah Punya Akun? ',
                        style: TextStyle(color: dark),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          ' Masuk',
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
