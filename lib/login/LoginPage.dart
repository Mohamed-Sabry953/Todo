import 'package:flutter/material.dart';
import 'package:todo/Homelayout.dart';
import 'package:todo/Shared/network/Firebase/firebaseFunictions.dart';
import 'package:todo/signUp/signup.dart';

class Login extends StatelessWidget {
  static const String routeName = 'Login';
  var formkey=GlobalKey<FormState>();
  TextEditingController emailcontroler=TextEditingController();
  TextEditingController passcontroler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.only(
            top: 110, bottom: 90, start: 15, end: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formkey,

            child: Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 150,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailcontroler,
                      validator:validateEmail,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passcontroler,
                      validator: validatepassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 30, left: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      if(formkey.currentState!.validate()){
                        firebaseFunictions.Login(emailcontroler.text, passcontroler.text, (){
                          Navigator.pushNamedAndRemoveUntil(context, Homelayout.routeName, (route) => false);
                        }).catchError((e){
                          Text(e.toString());
                        });
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, fixedSize: Size(10000, 50)),
                  ),
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have you account ?',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w500
                    )),
                    SizedBox(width: 2,),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, Signup.routeName);
                      },
                      child: Text('Create account',style: TextStyle(
                        color: Colors.blue, fontSize: 16,fontWeight: FontWeight.w500
                      ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('gmail.com')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }}
  String? validatepassword(String? value) {
    if (value != null) {
      if (value.length > 5 ) {
        return null;
      }
      return 'Enter a Valid password';
    }}
}
