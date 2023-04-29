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
  }

  int _getsteps = 0;
  double _totalEnergyBurned = 0.0;
  List<String> _heartRateData = [];
  double bodytemp = 0.0;

  HealthFactory health = HealthFactory();

  Future fetchStepData() async {
    int? steps;

    var types = [
      HealthDataType.STEPS,
    ];

    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    var Permissions = [
      HealthDataAccess.READ,
    ];

    bool requested =
        await health.requestAuthorization(types, permissions: Permissions);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("get exception in getTotalStepsInInterval $error");
      }

      setState(() {
        _getsteps = (steps == null) ? 0 : steps;
      });
    } else {
      print("Autorization not granted");
    }
  }

  Future<void> _getHealthData() async {
    try {
      var Permissions = [
        HealthDataAccess.READ,
        HealthDataAccess.READ,
        HealthDataAccess.READ,
      ];
      var type = [
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.HEART_RATE,
        HealthDataType.BODY_TEMPERATURE
      ];
      bool isAuthorized =
          await health.requestAuthorization(type, permissions: Permissions);
      if (!isAuthorized) {
        return;
      }

      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(const Duration(days: 7));
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(startDate, endDate, type);

      double totalEnergyBurned = 0.0;
      for (HealthDataPoint dataPoint in healthData) {
        if (dataPoint.type == HealthDataType.BASAL_ENERGY_BURNED) {
          totalEnergyBurned += dataPoint.value as double;
        }
      }

      List<String> heartRateStrings = [];

      for (var dataPoint in healthData) {
        if (dataPoint.type == HealthDataType.HEART_RATE) {
          String heartRateString =
              'Heart rate: ${dataPoint.value} bpm'; // format heart rate as a string
          heartRateStrings.add(heartRateString);
        } // add heart rate string to list
      }
      List<HealthDataPoint> tempList = [];
      for (HealthDataPoint dataPoint in healthData) {
        if (dataPoint.type == HealthDataType.BODY_TEMPERATURE) {
          tempList.add(dataPoint);
        }
      }
      double latestBodyTemperature = tempList.last.value as double;
      setState(() {
        _totalEnergyBurned = totalEnergyBurned;
        _heartRateData = heartRateStrings;
        bodytemp = latestBodyTemperature;
      });
    } catch (e) {
      print(e.toString());
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
              children: [
            Text('Total number of Steps today $_getsteps'),
            const SizedBox(
              height: 10,
            ),
            Text(
                'Total active energy burned: ${_totalEnergyBurned.toDouble()}'),
            const SizedBox(
              height: 10,
            ),
            Text(_heartRateData.join()),
            Text('Body Temperature $bodytemp'),
          ])),
    );
  }
}
