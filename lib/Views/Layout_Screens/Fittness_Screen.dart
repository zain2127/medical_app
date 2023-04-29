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
    fetchStepData();
    _getHealthData();
    _getHeartRateData();
    getLatestBodyTemperature();
  }

  int _getsteps = 0;
  double _totalEnergyBurned = 0.0;
  List<String> _heartRateData = [];
  List<String> bodytemp = [];

  HealthFactory health = HealthFactory();

  Future fetchStepData () async
  {
    int ? steps;

    var types = [
      HealthDataType.STEPS,
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

            }
            catch(error){
              print("get exception in getTotalStepsInInterval $error");
            }

            setState(() {
              _getsteps = (steps == null)?0:steps;
            });
      }
    else
      {
        print("Autorization not granted");
      }

  }
  Future<void> _getHealthData() async {
    try {
      var Permissions = [
        HealthDataAccess.READ,
      ];
      var type=[
        HealthDataType.ACTIVE_ENERGY_BURNED
      ];
      bool isAuthorized = await health.requestAuthorization(type,permissions: Permissions);
      if (!isAuthorized) {
        return;
      }

      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(const Duration(days: 7));
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        startDate,
        endDate,
        type
      );

      double totalEnergyBurned = 0.0;
      for (HealthDataPoint dataPoint in healthData) {
        totalEnergyBurned += dataPoint.value as double  ;
      }

      setState(() {
        _totalEnergyBurned = totalEnergyBurned;
      });
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _getHeartRateData() async {
    var Permissions = [
      HealthDataAccess.READ,
    ];
    var type=[
      HealthDataType.HEART_RATE
    ];
    bool isAuthorized = await health.requestAuthorization(type,permissions: Permissions);
    if (!isAuthorized) {
      return;
    }
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(days: 7));

    List<HealthDataPoint> heartRateData = await health.getHealthDataFromTypes(
      startDate,
      endDate,
      type
    );

    List<String> heartRateStrings = [];

    for (var dataPoint in heartRateData) {
      String heartRateString = 'Heart rate: ${dataPoint.value} bpm'; // format heart rate as a string
      heartRateStrings.add(heartRateString); // add heart rate string to list
    }

    setState(() {
      _heartRateData = heartRateStrings;
    });
  }

  Future<double> getLatestBodyTemperature() async {
    // Request permission to access health data.
    HealthFactory health = HealthFactory();
    List<HealthDataType> types = [HealthDataType.BODY_TEMPERATURE];
    bool accessWasGranted = await health.requestAuthorization(types);

    if (accessWasGranted) {
      // Retrieve body temperature data.
      List<HealthDataPoint> bodyTemperatureData = await health.getHealthDataFromTypes(
         DateTime.now().subtract(Duration(days: 7)), // start date
         DateTime.now(),
        types// end date
      );

      if (bodyTemperatureData.isNotEmpty) {
        // Get the latest body temperature value.
        double latestBodyTemperature = bodyTemperatureData.last.value as double;
        return latestBodyTemperature;
      } else {
        throw 'No body temperature data available';
      }
    } else {
      throw 'Authorization not granted';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
                    Text('Total number of Steps today $_getsteps'),
                    const SizedBox(height: 10,),
              Text('Total active energy burned: ${_totalEnergyBurned.toDouble()}'),
              const SizedBox(height: 10,),
          Text(_heartRateData.join()),
              Text('Body Temperature $bodytemp'),

          ]
      )
      ),
    );
  }
}
