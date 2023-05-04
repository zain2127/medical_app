import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health/health.dart';
import 'package:medical_app/Utils/Vitals_Card.dart';

class FitnessScreen extends StatefulWidget {
  @override
  _FitnessScreenState createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  List<HealthDataPoint> _healthData = [];

  @override
  void initState() {
    super.initState();
    _getHealthData();
  }

  Future<void> _getHealthData() async {
    // Request permission to access health data
    HealthFactory health = HealthFactory();
    List<HealthDataType> types = [HealthDataType.STEPS, HealthDataType.WEIGHT,HealthDataType.HEART_RATE,HealthDataType.SLEEP_ASLEEP];
    var permissions = [HealthDataAccess.READ,HealthDataAccess.READ,HealthDataAccess.READ,HealthDataAccess.READ];
    bool granted = await health.requestAuthorization(types,permissions: permissions);

    if (granted) {
      // Retrieve health data
      DateTime startDate = DateTime.now().subtract(Duration(days: 7));
      DateTime endDate = DateTime.now();
      List<HealthDataPoint> data = await health.getHealthDataFromTypes(startDate, endDate, types);

      setState(() {
        _healthData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4.5;
    final double itemWidth = size.width /1.2;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children:const [
                Icon(FontAwesomeIcons.hand,size: 30,),
                SizedBox(width: 8,),
                Text("Welcome to \n Fitness Screen",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
              ],
            ),
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(12.0)
              ),
              child: Row(
                children: [
                  //animated picture
                  Container(
                    height: 140,
                    width: 140,
                    color: Colors.deepPurple[30],
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset('lib/icons/9362.jpg',fit: BoxFit.contain)),

                  ),
                  const SizedBox(width: 20,),
                  // how do you feel + get started button
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('How do you feel ? ',style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 18.0,color: Colors.white
                        ),),
                        const SizedBox(height: 8,),
                        const Text('Want to explore the exercises',style: TextStyle(fontSize: 14,color: Colors.white),),
                        const SizedBox(height: 14,),
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(color: Colors.black87,
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: const Center(child:
                          Text('Get Started',style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold),),),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children:const [
                Icon(FontAwesomeIcons.circleCheck,size: 30,),
                SizedBox(width: 8,),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Vitals",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),]
            ),
          ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: itemWidth / itemHeight),
              children: [
                VitalCard(Icons: FontAwesomeIcons.personWalking, Vitalname: 'Steps', vitals: '${_getTotalSteps().toInt()} steps'),
                VitalCard(Icons: FontAwesomeIcons.weightScale, Vitalname: 'Weight', vitals: '${_getWeight().toInt()} kg'),
                VitalCard(Icons: FontAwesomeIcons.heartPulse, Vitalname: 'Heartbeat', vitals: '${getheartrate().toInt()} bpm'),
                VitalCard(Icons: Icons.bed, Vitalname: 'Sleep', vitals: '${getsleep().toInt()} min')
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getTotalSteps() {
    double totalSteps = 0;
    for (HealthDataPoint point in _healthData) {
      if (point.type == HealthDataType.STEPS) {
        totalSteps += double.parse(point.value.toString());
      }
    }
    return totalSteps;
  }

  double _getWeight() {
    for (HealthDataPoint point in _healthData) {
      if (point.type == HealthDataType.WEIGHT) {
        return double.parse(point.value.toString());
      }
    }
    return 0.0;
  }

  double getheartrate() {
    for (HealthDataPoint point in _healthData) {
      if (point.type == HealthDataType.HEART_RATE) {
        return double.parse(point.value.toString());
      }
    }
    return 0.0;
  }
  double getsleep() {
    for (HealthDataPoint point in _healthData) {
      if (point.type == HealthDataType.SLEEP_ASLEEP) {
        return double.parse(point.value.toString());
      }
    }
    return 0.0;
  }
}
