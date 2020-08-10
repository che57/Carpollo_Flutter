import 'package:carpollo/Scenes/forum/forum.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:carpollo/apiSheet.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: LoginForm(),
          padding: EdgeInsets.only(top: 100.0),
          width: 250.0,
        ),
      )
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text('Login'),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Enter your email',

            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: pwdController,
            decoration: const InputDecoration(
              hintText: 'Enter your password',

            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: clickLogin,
                child: Text('Login'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void clickLogin() async {
//    print('email: ' + emailController.text + ' password: ' + pwdController.text);
//    Response res = await postSignIn(email: emailController.text, password: pwdController.text);
//    print(res.data['username']);
//    print(res.data['jwt']);
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ForumPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.5, 1.0);
        var end = Offset.zero;
//        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
//    Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => ForumPage()),
//    );
  }

  Future<Response> postSignIn({@required String email, @required String password}) async {
    return Api.instance.signIn(email: email, password: password);
  }
}
