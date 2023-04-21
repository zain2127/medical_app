import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String DoctorImagepath;
  final  int rating;
  final String Name;
  final String title;

  DoctorCard({required this.DoctorImagepath, required this.rating, required this.title , required this.Name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0,right: 10,top: 8,bottom: 10),
        decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(12.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //pic of doctor
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(DoctorImagepath,height: 120,)),
            const SizedBox(height: 10,),
            //rating out of 5
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star,color: Colors.yellowAccent[700],),
                const SizedBox(width: 3,),
                Text("$rating"),
              ],
            ),
            const SizedBox(height: 5,),
            //doctor name
            Text(Name, style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
            //doctor title
            const SizedBox(height: 5,),
            Text(title)
          ],
        ),
      ),
    );
  }
}