

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Personal_info_Screen extends StatefulWidget {
  const Personal_info_Screen({super.key});

  @override
  State<Personal_info_Screen> createState() => _Personal_info_ScreenState();
}

class _Personal_info_ScreenState extends State<Personal_info_Screen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Info"),backgroundColor: Colors.black54,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.circleInfo,size: 30,),
                SizedBox(width: 8,),
                Text("Credentials",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("User Id:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text(auth.currentUser!.uid.toString(),style: TextStyle(fontSize: 16),)
              ],
            ),
            SizedBox(height: 8,),
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
          ],
        ),
      ),
    );
  }
}
