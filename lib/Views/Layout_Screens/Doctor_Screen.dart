import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app/Utils/Category_Card.dart';
import 'package:medical_app/Utils/Doctor_Card.dart';
import 'package:http/http.dart' as http;
import 'package:medical_app/Views/Layout_Screens/Doctor_Category_Screens/Dentist.dart';
import 'package:medical_app/Views/Layout_Screens/Doctor_Category_Screens/OtherDoctors.dart';
import 'package:medical_app/Views/Layout_Screens/Doctor_Category_Screens/Surgeon.dart';
import 'package:medical_app/Views/Layout_Screens/Doctor_List%20page.dart';

import 'doctor_details.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  Future getDataFromApi() async {
    const String baseUrl = 'https://medicalapp111.azurewebsites.net/doctor/';

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SafeArea(
        child: Column(
          children: [
            //appbar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        'Doctor Screen',
                        style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  //profile picture
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Icon(Icons.person),)

                ],
              ),
            ),
            const SizedBox(height: 25,),
            //card ->how do you feel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(12.0)
                ),
                child: Row(
                  children: [
                    //animated picture
                    Container(

                      height: 130,
                      width: 130,
                      color: Colors.deepPurple[30],
                      child: Image.asset('lib/icons/check-up.png',fit: BoxFit.contain),

                    ),
                    const SizedBox(width: 20,),
                    // how do you feel + get started button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('How do you feel ? ',style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),),
                          const SizedBox(height: 8,),
                          const Text('Fill out your medical card right now'),
                          const SizedBox(height: 12,),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            child: const Center(child: Text('Get Started',style: TextStyle(color: Colors.white),),),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25.0,),
            //horizontal listview ->categories: dentist , surgeon etc..
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DentistScreen()));
                      },
                      child: CategoryCard(Icon: 'lib/icons/tooth.png',categoryname: 'Dentist')),
                  InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SurgeonScreen()));
                      },
                      child: CategoryCard(Icon: 'lib/icons/surgeon.png',categoryname: 'Surgeon')),
                  InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherDoctorScreen()));
                      },
                      child: CategoryCard(Icon: 'lib/icons/drugs.png',categoryname: 'Others')),
                ],
              ),
            ),
            const SizedBox(height: 25.0,),
            // doctor list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text('Doctor List' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  InkWell(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorList()));
                      },
                      child: const Text('See all' , style: TextStyle(fontSize: 16 , color: Colors.grey),))
                ],
              ),
            ),
            const SizedBox(height: 12,),
            FutureBuilder(
              future: getDataFromApi(),
              builder: (BuildContext context , snapshot)
                {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  else
                  {
                    final data= snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (BuildContext context , int index)
                        {
                          return  data != null
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: ()
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        DoctorDetails(
                                          name:  data["doctor"][index]["name"],
                                          speciality: data["doctor"][index]["specialtiy"],
                                          image: data["doctor"][index]["image"],
                                          rating: data["doctor"][index]["rating"],
                                          education: data["doctor"][index]["education"],
                                          email: data["doctor"][index]["email"],
                                        )));
                                  },
                                  child: DoctorCard(
                                  DoctorImagepath: data["doctor"][index]["image"],
                                  rating: data["doctor"][index]["rating"],
                                  title: data["doctor"][index]["specialtiy"],
                                  Name: data["doctor"][index]["name"]),
                                ),
                              )
                              : Container();
                        },


                      ),
                    );
                  }
                },
            )
          ],
        ),
      ),
    );
  }
}