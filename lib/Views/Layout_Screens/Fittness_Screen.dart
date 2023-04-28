import 'package:flutter/material.dart';
import 'package:health/health.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({Key? key}) : super(key: key);

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  int _getsteps = 0;
  int activeenergy=0;

  HealthFactory health = HealthFactory();

  Future fetchData () async
  {
    int ? steps;
    int ? burnedenergy;

    var types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    final now = DateTime.now();
    final midnight = DateTime(now.year,now.month,now.day);

    var Permissions = [
      HealthDataAccess.READ,
    ];

    bool requested = await health.requestAuthorization(types,permissions: Permissions);

    if(requested)
      {
        try
            {
              steps = await health.getTotalStepsInInterval(midnight, now);
              burnedenergy= (await health.getHealthDataFromTypes(midnight, now, types)) as int?;
            }
            catch(error){
              print("get exception in getTotalStepsInInterval $error");
            }

            setState(() {
              _getsteps = (steps == null)?0:steps;
              activeenergy = (burnedenergy==null)?0:burnedenergy;
            });
      }
    else
      {
        print("Autorization not granted");
      }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
        Text('Total number of Steps today $_getsteps'),
        SizedBox(height: 10,),
        Text('Total number of energy burned $activeenergy'),

      ]),
    );
  }
}
