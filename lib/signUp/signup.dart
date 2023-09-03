import 'package:flutter/material.dart';
import 'package:todo/Shared/network/Firebase/firebaseFunictions.dart';
import 'package:todo/login/LoginPage.dart';

class Signup extends StatelessWidget {
  static const String routeName='signup';

  var formkey=GlobalKey<FormState>();
  final TextEditingController pass=TextEditingController();
  final TextEditingController email=TextEditingController();
  final TextEditingController Phone=TextEditingController();
  final TextEditingController Name=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.only(
            top: 50, bottom: 20, start: 15, end: 15),
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
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: Name,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: email,
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
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: Phone,
                      validator:validateMobile,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'phone number',
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
                      controller: pass,
                      validator: validatePassword,
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: validateConfirmPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'confirm password ',
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
                        firebaseFunictions.Signup(Name.text,email.text, pass.text,int.parse(Phone.text),(){
                          Navigator.pop(context);
                        }).catchError((e){
                          print('error');
                        });
                      }
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, fixedSize: Size(10000, 50)),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have you account ?',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w500
                    )),
                    SizedBox(width: 2,),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context, routeName);
                      },
                      child: Text('Login',style: TextStyle(
                          color: Colors.blue, fontSize: 16,fontWeight: FontWeight.w500
                      ),),
                    ),
                  ],
                ),
                SizedBox(height: 30,)
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
  String? validatePassword(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
  String? validateConfirmPassword(String? value) {
    if(value!.isEmpty)
      return 'Empty';
    if(value != pass.text) {
      return 'Not Match';
    }
    return null;
  }
  String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length != 11)
      return 'Mobile Number must be of 10 digit';
    else {
      return null;
    }
  }
}
