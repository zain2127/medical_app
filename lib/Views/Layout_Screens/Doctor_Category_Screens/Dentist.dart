import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:medical_app/Utils/Doctor_Card.dart';
import 'package:medical_app/Views/Layout_Screens/doctor_details.dart';

class DentistScreen extends StatefulWidget {
  const DentistScreen({Key? key}) : super(key: key);

  @override
  State<DentistScreen> createState() => _DentistScreenState();
}

class _DentistScreenState extends State<DentistScreen> {


  Future getDataFromApi() async {
    const String baseUrl = 'https://medicalapp121.azurewebsites.net/doctor/';

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final dentistdoctor=data["doctor"].where((doctor) => doctor["specialtiy"] == "dentist" || doctor["specialtiy"]=="Dentist")
          .toList();
      return dentistdoctor;
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
          title: const Text("Dentist List",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue[100],
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
        ),
        body: FutureBuilder(
          future: getDataFromApi(),
          builder: (BuildContext context, snapshot) {
            final dentistDoctors = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: dentistDoctors?.length,
                  itemBuilder: (BuildContext context, int index) {
                    final doctor = dentistDoctors[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DoctorDetails(
                              name: doctor["name"],
                              speciality: doctor["specialtiy"],
                              image: doctor["image"],
                              rating: doctor["rating"],
                              education: doctor["education"],
                              email: doctor["email"],
                            )),
                          );
                        });
                      },
                      child: DoctorCard(
                        DoctorImagepath: doctor["image"],
                        rating: doctor["rating"],
                        title: doctor["specialtiy"],
                        Name: doctor["name"],
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: itemWidth / itemHeight,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                ),
              );
            }
          },
        )

    );
  }
}
