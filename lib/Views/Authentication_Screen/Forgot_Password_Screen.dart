import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Utils/utils.dart';
import 'package:medical_app/Views/Authentication_Screen/Signin_Screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool loading = false;

  Future<void> resetPassword(String email) async {
    try {
      setState(() {
        loading = true;
      });
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value){
        setState(() {
          loading = false;
        });
        Utils().successMessage("Email sent , Please check your email to reset your password");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utils().errorMessage(error.toString());
      });
    } catch (error) {
      setState(() {
        loading = false;
      });
      Utils().errorMessage(error.toString());
    }
  }


  Future<void> _handleResetPassword() async {
    String email = _emailController.text.trim();

    // Perform input validation here if needed

    await resetPassword(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: Text('Type in your email to reset password',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
            SizedBox(height: 10,),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleResetPassword,
              child: Center(child: loading == true ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) :Text('Reset Password')),
            ),
          ],
        ),
      ),
    );
  }
}
