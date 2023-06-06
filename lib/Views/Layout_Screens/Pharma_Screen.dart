import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:medical_app/Utils/Medicine_Card.dart';
import 'package:medical_app/Views/Layout_Screens/medicine_details.dart';
import 'package:medical_app/Views/Map_Screens/clinic_Screen.dart';
import 'package:medical_app/Views/Map_Screens/hospital_screen.dart';
import 'package:medical_app/Views/Map_Screens/pharmacy_Screen.dart';

class PharmaPage extends StatefulWidget {
  const PharmaPage({Key? key}) : super(key: key);

  @override
  State<PharmaPage> createState() => _PharmaPageState();
}

class _PharmaPageState extends State<PharmaPage> {
  Future getDataFromApi() async {
    const String baseUrl = 'https://medicalapp121.azurewebsites.net/medicine/';

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
    final double itemWidth = size.width /1.2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
        Colors.white,elevation: 0,
        centerTitle: false,
        title: Row(
          children: const [
              Icon(FontAwesomeIcons.mapLocationDot,color: Colors.orange,),
             SizedBox(width: 10,),
             Text('Near By',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 25,),),
          ],
        ),),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: InkWell(
                          onTap: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyHospitals()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(12)
                          ),
                            child: Row(
                                children: const [
                                    Icon(FontAwesomeIcons.hospital,size: 25,),
                                    SizedBox(width: 15,),
                                    Text('Hospital',style: TextStyle(fontSize: 18),)
              ],
          ),
        ),
                        ),
      ),
                      Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyClinic()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          children: const [
                            Icon(FontAwesomeIcons.houseChimneyMedical,size: 25,),
                            SizedBox(width: 15,),
                            Text('Clinic',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                      ),
                    ),
                  ),
                      Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: InkWell(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPharmacy()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          children: const [
                            Icon(FontAwesomeIcons.bandage,size: 25,),
                            SizedBox(width: 15,),
                            Text('Pharmacy',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                      ),
                    ),
                  ),
              ],),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 8,left: 16,bottom: 4),
              child: Row(
                children: const [
                  Icon(FontAwesomeIcons.tablets,color: Colors.orange,size: 25,),
                  SizedBox(width: 10,),
                  Text('Medicine',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 25,),),
                ],
              ),
            ),
            FutureBuilder(
              future: getDataFromApi(),
              builder: (BuildContext context, snapshot)
              {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                else
                {
                  final data= snapshot.data!;
                  return Flexible(
                    child: GridView.builder(
                      itemCount: data["medicine"].length,
                      itemBuilder: (BuildContext context , int index)
                      {
                        return  data != null
                            ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    MedicineDetailsScreen(
                                        drugName: data['medicine'][index]['drugname'],
                                        dosageForm: data['medicine'][index]['dosage_form'],
                                        dosageStrength: data['medicine'][index]['dosageStrength'].toString(),
                                        contraindications: data['medicine'][index]['contradictions'],
                                        sideEffects: data['medicine'][index]['side_effect'],
                                        storage: data['medicine'][index]['storage'],
                                        imageUrl: data['medicine'][index]['image'],
                                      indications: data['medicine'][index]['indications'],

                                    )));
                              },
                              child: MedicineCard(
                                  MedicineImagepath: data['medicine'][index]['image'],
                                  dosage: data['medicine'][index]['dosageStrength'],
                                  Dosage_Form: data['medicine'][index]['dosage_form'],
                                  Drug_Name: data['medicine'][index]['drugname']),
                            )
                        )
                            : Container();
                      }, gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:  itemWidth / itemHeight,

                    ),


                    ),
                  );
                }
              },

            ),

          ],
        ),
      )
    );
  }
}
