import 'package:b_health/src/models/blood_glucose.dart';
import 'package:health/health.dart';

class HealthRepository {
  final health = HealthFactory();

  Future<List<BloodGlucose>> getBloodGlucose() async {
    bool requested =
        await health.requestAuthorization([HealthDataType.BLOOD_GLUCOSE]);

    if (requested) {
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          DateTime.now().subtract(const Duration(days: 7)),
          DateTime.now(),
          [HealthDataType.BLOOD_GLUCOSE]);

      return healthData.map((e) {
        var b = e;
        print(b.value.toJson()['numericValue']);
        return BloodGlucose(
          double.parse(b.value.toJson()['numericValue']),
          b.unitString,
          b.dateFrom,
          b.dateTo,
        );
      }).toList();
    }
    return [];
  }
}

/*
/ create a HealthFactory for use in the app
    final health = HealthFactory(useHealthConnectIfAvailable: false);

    // define the types to get
    var types = [
      HealthDataType.WEIGHT,
      HealthDataType.STEPS,
      HealthDataType.HEIGHT,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.WORKOUT,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    ];

    // requesting access to the data types before reading them
    bool requested = await health.requestAuthorization(types);

    var now = DateTime.now();

    // fetch health data from the last 24 hours
    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        now.subtract(const Duration(days: 1)), now, types);

    // request permissions to write steps and blood glucose
    var permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();

    await health.requestAuthorization(types, permissions: permissions);

    // write steps and blood glucose
    bool success =
        await health.writeHealthData(10, HealthDataType.BLOOD_OXYGEN, now, now);
    success = await health.writeHealthData(
        3.1, HealthDataType.BLOOD_GLUCOSE, now, now);

    // get the number of steps for today
    var midnight = DateTime(now.year, now.month, now.day);
    int? steps = await health.getTotalStepsInInterval(midnight, now);
    print(healthData);
*/