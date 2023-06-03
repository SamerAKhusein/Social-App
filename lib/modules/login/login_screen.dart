import 'package:flutter/material.dart';



class SocialLoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Login now to browse our hot offers',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  SizedBox(
                    height: 15.0,
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),

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