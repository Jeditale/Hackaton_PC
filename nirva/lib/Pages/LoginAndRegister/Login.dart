import 'package:flutter/material.dart';
import 'package:nirva/Pages/mainmenu_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login",style: TextStyle(fontSize: 30)), backgroundColor: const Color.fromARGB(255, 184, 231, 255),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("E-mail",style: TextStyle(fontSize: 30)),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                ),
                Text("Password",style: TextStyle(fontSize: 30)),
                TextFormField(
                  obscureText: true,
                ),

                SizedBox(height: 20,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return MainMenu();

                })
                );
                  }, 
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text("Login",style: TextStyle(fontSize: 30, color: Colors.white))),
                )
              ],
            )),
        ),
      ),
    );
  }
}