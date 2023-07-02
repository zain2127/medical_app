import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Utils/utils.dart';
import 'package:medical_app/Views/Authentication_Screen/verify_phone_code.dart';

class Login_with_phoneNumber extends StatefulWidget {
  const Login_with_phoneNumber({super.key});

  @override
  State<Login_with_phoneNumber> createState() => _Login_with_phoneNumberState();
}

class _Login_with_phoneNumberState extends State<Login_with_phoneNumber> {
  TextEditingController phone_controller = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login with phone number'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            TextFormField(
              controller: phone_controller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: '+1 234 3456 789',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: (){
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: phone_controller.text,
                    verificationCompleted: (_){},
                    verificationFailed: (e){
                      setState(() {
                        loading = false;
                      });
                      Utils().errorMessage(e.toString());
                    },
                    codeSent: (String verificationId , int ? token){
                      setState(() {
                        loading = false;
                      });
                      Utils().successMessage('code sent');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Verify_with_phoneNumber(VerificationId: verificationId,)));
                    },
                    codeAutoRetrievalTimeout: (e){
                      setState(() {
                        loading = false;
                      });
                      Utils().errorMessage(e.toString());
                    }, );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue.shade400
                ),
                child:  Center(
                    child: loading == true ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) :Text('Login',
                      style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),)),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
