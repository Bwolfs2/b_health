import 'package:b_health/src/ui/pages/home/home_controller.dart';
import 'package:b_health/src/ui/widgets/my_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //  FloatingActionButton(
          //    onPressed: () => controller.getDataFirebase(),
          //    child: const Icon(Icons.data_array),
          //  ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => controller.getData(),
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.blodGlucoses,
        builder: (context, value, child) {
          return GridView(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              children: [
                for (final bloodGlucose in value)
                  MyCard(bloodGlucose: bloodGlucose),
              ]);
        },
      ),
    );
  }
}
