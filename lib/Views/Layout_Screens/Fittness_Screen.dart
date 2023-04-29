import 'package:flutter/material.dart';
import 'package:health/health.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({Key? key}) : super(key: key);

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  @override
  String bmi = 'No data';
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStepData();
    _getHealthData();
    _getHeartRateData();
    getLatestBMI().then((value){
      setState(() {
        bmi=value.toString();
      });
    });
    getTotalSleepTime();
  }

  int _getsteps = 0;
  double _totalEnergyBurned = 0.0;
  List<String> _heartRateData = [];
  HealthFactory health = HealthFactory();
  int sleeptime=0;

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
        totalEnergyBurned += double.parse(dataPoint.value.toString());
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
  Future<double> getLatestBMI() async {
    // Get the latest body mass index data

    var types = [HealthDataType.BODY_MASS_INDEX];
    var Permissions = [
      HealthDataAccess.READ,
    ];
    var type=[
      HealthDataType.BODY_MASS_INDEX
    ];
    bool isAuthorized = await health.requestAuthorization(type,permissions: Permissions);
    if (!isAuthorized) {
      return 1.0;}
    List<HealthDataPoint> bodyMassIndexData =
    await health.getHealthDataFromTypes(
        DateTime.now(),
        DateTime.now().subtract(Duration(days: 1)),
        types
    );

    // If there is no body mass index data available, return null
    if (bodyMassIndexData.isEmpty) {
      return 0.0;
    }

    // Get the latest body mass index value as a double
    NumericHealthValue bodyMassIndexValue =
    bodyMassIndexData[0].value as NumericHealthValue;
    double bmi = double.parse(bodyMassIndexValue.toString());

    return bmi;
  }
  Future<int> getTotalSleepTime() async {
    // Check if the user has authorized access to sleep data
    var type=[HealthDataType.SLEEP_ASLEEP];
    var Permissions = [
      HealthDataAccess.READ,
    ];
    bool isAuthorized = await health.requestAuthorization(type,permissions: Permissions);

    if (!isAuthorized) {
      // User did not authorize access to sleep data
      print("error");
    }

    // Define the start and end times for the query
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month, now.day);
    DateTime endDate = now;

    // Query the HealthKit database for sleep data
    List<HealthDataPoint> data = await health.getHealthDataFromTypes(
        startDate,
        endDate,
        type
    );

    // Calculate the total sleep time
    int totalSleepTime = 0;

    for (var sleep in data) {
      HealthDataUnit unit = sleep.unit;

      if (unit == HealthDataUnit.SECOND || unit == HealthDataUnit.MINUTE || unit == HealthDataUnit.HOUR) {
        NumericHealthValue value = sleep.value as NumericHealthValue;
        totalSleepTime += int.parse(value.toString());
      }
    }
    sleeptime =totalSleepTime;

    // Return the total sleep time in seconds
    return sleeptime;
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
                SizedBox(height: 10,),
                Text(
                  'BMI: $bmi',
                  style: TextStyle(fontSize: 20),),
                Text("Total Sleep time "+sleeptime.toInt().toString())
              ]
          )
      ),
    );
  }
}

