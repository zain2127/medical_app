import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Views/Layout_Screens/Bottom_Navigation_screen.dart';

import '../../Utils/utils.dart';

class Verify_with_phoneNumber extends StatefulWidget {
  final String VerificationId;
  const Verify_with_phoneNumber({super.key, required this.VerificationId});

  @override
  State<Verify_with_phoneNumber> createState() => _Verify_with_phoneNumberState();
}

class _Verify_with_phoneNumberState extends State<Verify_with_phoneNumber> {
  TextEditingController code_controller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify with phone number'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
              controller: code_controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '+Enter code',
              ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: ()async{
                final credentials = PhoneAuthProvider.credential(verificationId: widget.VerificationId, smsCode: code_controller.text.toString());
                try{
                  auth.signInWithCredential(credentials);
                  Utils().successMessage("Login Successful");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationScreen()));
                }
                catch(e)
                {
                  Utils().errorMessage(e.toString());
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue.shade400
                ),
                child: const Center(
                    child: Text('Verify',
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

