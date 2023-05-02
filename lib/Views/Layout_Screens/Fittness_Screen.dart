import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({Key? key}) : super(key: key);

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  @override
  String bmi = 'No data';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStepData();
  }

  int _getsteps = 0;
  double _totalEnergyBurned = 0.0;
  List<String> _heartRateData = [];
  HealthFactory health = HealthFactory();
  int sleeptime = 0;

  Future fetchStepData() async {
    int? steps;

    var types = [
      HealthDataType.STEPS,
    ];

    final now = DateTime.now();
    final midnight = now.subtract(const Duration(days: 7));

    var Permissions = [
      HealthDataAccess.READ,
    ];
    await Permission.activityRecognition.request();
    await Permission.location.request();
    bool? hasPermissions =
        await health.hasPermissions(types, permissions: Permissions);

    // hasPermissions = false because the hasPermission cannot disclose if WRITE access exists.
    // Hence, we have to request with WRITE as well.
    hasPermissions = false;

    if (!hasPermissions) {
      bool requested =
          await health.requestAuthorization(types, permissions: Permissions);

      if (requested) {
        try {
          steps = await health.getTotalStepsInInterval(midnight, now);
          await _getHealthData([
            HealthDataType.ACTIVE_ENERGY_BURNED,
            HealthDataType.HEART_RATE,
            HealthDataType.BODY_MASS_INDEX,
            HealthDataType.SLEEP_ASLEEP
          ], [
            HealthDataAccess.READ,
            HealthDataAccess.READ,
            HealthDataAccess.READ,
            HealthDataAccess.READ,
          ]);
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
  }

  Future<void> _getHealthData(
      List<HealthDataType> type, List<HealthDataAccess> permissions) async {
    bool? hasPermissions =
        await health.hasPermissions(type, permissions: permissions);
    if (hasPermissions!) {
      try {
        bool isAuthorized = await health.requestAuthorization(
          type,
        );
        if (!isAuthorized) {
          return;
        }

        DateTime endDate = DateTime.now();
        DateTime startDate = endDate.subtract(const Duration(days: 7));
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(startDate, endDate, type);

        double totalEnergyBurned = 0.0;
        for (HealthDataPoint dataPoint in healthData) {
          if (dataPoint.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
            totalEnergyBurned += double.parse(dataPoint.value.toString());
          }
        }
        List<String> heartRateStrings = [];

        for (var dataPoint in healthData) {
          if (dataPoint.type == HealthDataType.HEART_RATE) {
            String heartRateString =
                'Heart rate: ${dataPoint.value} bpm'; // format heart rate as a string
            heartRateStrings
                .add(heartRateString); // add heart rate string to list
          }
        }

        // Get the latest body mass index value as a double
        NumericHealthValue? bodyMassIndexValue;
        for (var dataPoint in healthData) {
          if (dataPoint.type == HealthDataType.BODY_MASS_INDEX) {
            bodyMassIndexValue = dataPoint.value as NumericHealthValue;
          }
        }

        int totalSleepTime = 0;

        for (var sleep in healthData) {
          if (sleep.type == HealthDataType.SLEEP_ASLEEP) {
            HealthDataUnit unit = sleep.unit;

            if (unit == HealthDataUnit.SECOND ||
                unit == HealthDataUnit.MINUTE ||
                unit == HealthDataUnit.HOUR) {
              NumericHealthValue value = sleep.value as NumericHealthValue;
              totalSleepTime += int.parse(value.toString());
            }
          }
        }

        setState(() {
          _totalEnergyBurned = totalEnergyBurned;
          _heartRateData = heartRateStrings;
          sleeptime = totalSleepTime;
          bmi = bodyMassIndexValue.toString();
        });
      } catch (e) {
        print(e.toString());
      }
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
            const SizedBox(
              height: 10,
            ),
            Text(
              'BMI: $bmi',
              style: const TextStyle(fontSize: 20),
            ),
            Text("Total Sleep time ${sleeptime.toInt()}")
          ])),
    );
  }
}
