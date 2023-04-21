import 'package:flutter/material.dart';

class MedicineCard extends StatelessWidget {
  final String MedicineImagepath;
  final  double dosage;
  final String Drug_Name;
  final String Dosage_Form;

  MedicineCard({required this.MedicineImagepath, required this.dosage, required this.Dosage_Form , required this.Drug_Name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0,right: 10,top: 8,bottom: 10),
        decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.circular(12.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //pic of doctor
            Container(
              height: 120,
              width: 200,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(MedicineImagepath,height: 120,)),
            ),
            const SizedBox(height: 10,),
            //rating out of 5
            //doctor name
            Text(Drug_Name, style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
            const SizedBox(height: 5,),
            Text("$dosage"+'mg'),
            //doctor title
            const SizedBox(height: 5,),
            Text(Dosage_Form)
          ],
        ),
      ),
    );
  }
}