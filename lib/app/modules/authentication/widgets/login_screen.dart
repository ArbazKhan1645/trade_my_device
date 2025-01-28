// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'textfield_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isobserve = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          'assets/images/trade.jpeg',
          height: 70,
        ),
        TextFieldWidget(hintText: 'Email', controller: emailController),
        TextFieldWidget(
            hintText: 'Password',
            controller: passwordController,
            iconbutton: IconButton(
                onPressed: () {
                  setState(() {
                    isobserve = !isobserve;
                  });
                },
                icon: Icon(isobserve == true
                    ? Icons.visibility
                    : Icons.visibility_off)),
            observe: isobserve),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Error encoutered while login the user',
                  style: TextStyle(color: Colors.amber),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              Checkbox(value: false, onChanged: (val) {}),
              const SizedBox(width: 10),
              const Text('I trust this browser')
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          child: MaterialButton(
            padding: const EdgeInsets.all(0),
            onPressed: () async {},
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.amber),
              child: Center(
                  child: false == false
                      ? const Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        )
                      : Center(
                          child: SpinKitThreeBounce(
                            color: Colors.black,
                            size: 20,
                          ),
                        )),
            ),
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'I forgot my password',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            )),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CONNECT WITH',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Row(
                        children: [
                          Image.asset('assets/images/google.png'),
                          const SizedBox(width: 10),
                          const Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ],
                      )),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MaterialButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Row(
                        children: [
                          Image.asset('assets/images/google.png'),
                          const SizedBox(width: 10),
                          const Text(
                            'Facebook',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'Dont have an account?',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            )),
      ],
    );
  }
}
