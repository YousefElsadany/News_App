import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/layout/NewsApp/NewsLayout.dart';
import 'package:news_app/shared/componants/componants.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: customTextFeild(
                      controller: _emailController,
                      inputType: TextInputType.emailAddress,
                      title: 'Email Address',
                      tap: () {},
                      pIcon: Icons.email,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  customTextFeild(
                    controller: _passwordController,
                    inputType: TextInputType.visiblePassword,
                    isPassword: isShow,
                    suffixPress: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    tap: () {},
                    title: 'Password',
                    pIcon: Icons.lock,
                    sIcon: isShow ? Icons.visibility_off : Icons.visibility,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'password is too short';
                      } else if (value.length < 6) {
                        return 'Password less than 6 charchtar ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  customButtom(
                      buttomCollor: Colors.deepOrange,
                      text: 'login',
                      press: () {
                        if (formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                        }
                        Get.off(NewsLayout());
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeLayout()),
                        );*/
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Sign Up'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
