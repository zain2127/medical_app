import 'package:flutter/material.dart';
import 'package:medical_app/Utils/exxercise_util.dart';
import 'package:medical_app/Views/Layout_Screens/exercises_screens/Abdominal.dart';
import 'package:medical_app/Views/Layout_Screens/exercises_screens/Biceps.dart';
import 'package:medical_app/Views/Layout_Screens/exercises_screens/Calves.dart';
import 'package:medical_app/Views/Layout_Screens/exercises_screens/Chest.dart';
import 'package:medical_app/Views/Layout_Screens/exercises_screens/Lower_back.dart';
import 'package:medical_app/Views/Layout_Screens/exercises_screens/Neck.dart';
import 'package:medical_app/Views/Layout_Screens/exercises_screens/Triceps.dart';
import 'package:medical_app/Views/Layout_Screens/exercises_screens/Upper_back.dart';

class Exercise_Dashboard extends StatefulWidget {
  const Exercise_Dashboard({Key? key}) : super(key: key);

  @override
  State<Exercise_Dashboard> createState() => _Exercise_DashboardState();
}

class _Exercise_DashboardState extends State<Exercise_Dashboard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4.5;
    final double itemWidth = size.width /1.2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise'),
        backgroundColor: Colors.green[300],
      ),
      body: Column(
        children:[
          Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: itemWidth / itemHeight),
            children:  [
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Biceps_Screen()));
                  },
                  child: Exercise_Card(Icon: 'lib/icons/muscle.png', categoryname: 'Biceps')),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Triceps_Screen()));
                  },
                  child: Exercise_Card(Icon: 'lib/icons/arm.png', categoryname: 'Triceps')),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Chest_Screen()));
                  },
                  child: Exercise_Card(Icon: 'lib/icons/body.png', categoryname: 'Chest')),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Upperback_Screen()));

                  },
                  child: Exercise_Card(Icon: 'lib/icons/upperback.png', categoryname: 'Upper back')),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Lowerback_Screen()));
                  },
                  child: Exercise_Card(Icon: 'lib/icons/lowerback.png', categoryname: 'Lower back')),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Abdominal_Screen()));
                  },
                  child: Exercise_Card(Icon: 'lib/icons/abdominal.png', categoryname: 'Abdominal')),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Calves_Screen()));
                  },
                  child: Exercise_Card(Icon: 'lib/icons/calves.png', categoryname: 'Calves')),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Neck_Screen()));
                  },
                  child: Exercise_Card(Icon: 'lib/icons/neck.png', categoryname: 'Neck')),


            ],),
        ),
    ]
      ),
    );
  }
}
