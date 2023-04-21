import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:medical_app/Utils/Doctor_Card.dart';
import 'package:medical_app/Views/Layout_Screens/doctor_details.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {


  Future getDataFromApi() async {
    const String baseUrl = 'https://medi-production-464c.up.railway.app/doctor/';

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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width /1.22;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text("Doctor List",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue[100],
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
        ),
        body: FutureBuilder(
            future: getDataFromApi(),
            builder: (BuildContext context, snapshot) {
              final data = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              else
                {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: data["doctor"].length,
                      itemBuilder: (BuildContext context , int index)
                      {
                        return  data != null
                            ? InkWell(
                              onTap: (){
                                setState(() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      DoctorDetails(
                                        name:  data["doctor"][index]["name"],
                                        speciality: data["doctor"][index]["specialtiy"],
                                        image: data["doctor"][index]["image"],
                                        rating: data["doctor"][index]["rating"],
                                        education: data["doctor"][index]["education"],
                                      )));
                                });
                              },
                              child: DoctorCard(
                                  DoctorImagepath: data["doctor"][index]["image"],
                                  rating: data["doctor"][index]["rating"],
                                  title: data["doctor"][index]["specialtiy"],
                                  Name: data["doctor"][index]["name"]),
                            )
                            : Container();
                      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      childAspectRatio: itemWidth / itemHeight,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                    ),


                    ),
                  );
                }
            }
        )
    );
  }
}
