import 'package:flutter/material.dart';
import 'package:nirva/Pages/LoginAndRegister/Login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up",style: TextStyle(fontSize: 30),),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name",style: TextStyle(fontSize: 30)),
                TextFormField(),
                Text("Phone Number",style: TextStyle(fontSize: 30)),
                TextFormField(),
                Text("E-mail",style: TextStyle(fontSize: 30)),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                ),
                Text("Password",style: TextStyle(fontSize: 30)),
                TextFormField(
                  obscureText: true,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return LoginScreen();

                })
                );
                  }, 
                  child: Text("Sign Up",style: TextStyle(fontSize: 30))),
                )
              ],
            )),
        ),
      ),
    );
  }
}