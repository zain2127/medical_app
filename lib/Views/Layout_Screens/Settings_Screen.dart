import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/Views/Authentication_Screen/Signin_Screen.dart';
import 'package:medical_app/Views/Layout_Screens/Setting_Screens/PersonalInfo_Screen.dart';
import 'package:medical_app/Views/Layout_Screens/Setting_Screens/PrivacyScreen.dart';
import 'package:medical_app/Views/Layout_Screens/Setting_Screens/Terms&condition.dart';

import '../../Utils/utils.dart';

class Setting_Screen extends StatefulWidget {
  const Setting_Screen({Key? key}) : super(key: key);

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  final auth = FirebaseAuth.instance;
   logout()
  {
      auth.signOut().then((value){
        Utils().successMessage("Logout Successful");
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const SignInScreen()));
      }).onError((error, stackTrace){
        Utils().errorMessage("Error occured while loging out");
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             ListTile(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Personal_info_Screen()));
              },
              leading: const Icon(Icons.person,size: 40,),
              title: const Text("Personal Info"),
            ),
             ListTile(
               onTap: ()
               {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const Privacy_Screen()));
               },
              leading: const Icon(FontAwesomeIcons.gear,size: 30,),
              title: const Text("Privacy"),
            ),
             ListTile(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditionsScreen()));
              },
              leading: const Icon(FontAwesomeIcons.bookOpen,size: 30,),
              title: const Text("Terms & Conditions"),
            ),
            ListTile(
              onTap: ()
              {
                logout();
              },
              leading: const Icon(FontAwesomeIcons.doorOpen,size: 30,),
              title: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
