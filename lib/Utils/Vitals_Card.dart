import 'package:flutter/material.dart';

class VitalCard extends StatelessWidget {
  final Icons;
  final String Vitalname;
  final String vitals;
  VitalCard({required this.Icons,required this.Vitalname, required this.vitals});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 150,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons,size: 40,),
                SizedBox(width: 10,),
                Text(Vitalname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
              ],
            ),
            SizedBox(height: 10,),
            Align(
                alignment: Alignment.bottomRight,
                child: Text(vitals,style: TextStyle(fontSize: 16),)),
          ],
        ),
      ),
    );
  }
}