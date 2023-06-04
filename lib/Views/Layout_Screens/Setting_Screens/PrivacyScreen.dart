

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/Utils/utils.dart';

class Privacy_Screen extends StatefulWidget {
  const Privacy_Screen({super.key});

  @override
  State<Privacy_Screen> createState() => _Privacy_ScreenState();
}

class _Privacy_ScreenState extends State<Privacy_Screen> {
  final auth = FirebaseAuth.instance;
  TextEditingController ?  updatepassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  updatePassword()
   {
    auth.currentUser!.updatePassword(updatepassword!.text.toString()).then((value){
      Utils().successMessage("password updated");
    }).onError((error, stackTrace){
      Utils().errorMessage("$error");
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    updatepassword!.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy"),backgroundColor: Colors.black54,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.lock,size: 30,),
                SizedBox(width: 8,),
                Text("Privacy Info",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 20,),
            auth.currentUser!.email == null ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Phone Number:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text(auth.currentUser!.phoneNumber.toString(),style: TextStyle(fontSize: 16),)
              ],
            ):
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("email:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text(auth.currentUser!.email.toString(),style: TextStyle(fontSize: 16),)
              ],
            ),
            SizedBox(height: 8,),
            OutlinedButton(onPressed: (){
              showDialog(context: context, builder: (context)
                  {
                    return Container(
                      child: AlertDialog(
                        title: Column(
                          children: [
                            Text("Update Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            SizedBox(height: 6,),
                            Form(
                              key: formKey,
                              child: TextFormField(
                                controller: updatepassword,
                                decoration: InputDecoration(hintText: "Enter new password"),
                                validator: (value){
                                  if(value!.isEmpty)
                                    {
                                      return "enter new password";
                                    }
                                },
                              ),
                            ),

                          ],
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            if(formKey.currentState!.validate())
                              {
                                updatePassword();
                                Navigator.pop(context);
                              }
                          }, child: Text('Update')),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text('Cancel')),

                        ],

                      ),
                    );
                  }
              );
            }, child: Text("Change Password"))
          ],
        ),
      ),
    );
  }
}
