import 'package:best_candidate/Dashboard/BuildingCv/nearbyOrganisations.dart';
import 'package:best_candidate/Dashboard/BuildingCv/plan_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuildingCv extends StatefulWidget {
  const BuildingCv({super.key});

  @override
  State<BuildingCv> createState() => _BuildingCvState();
}

class _BuildingCvState extends State<BuildingCv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text('Generate your Resume'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16,),
             GestureDetector(
              onTap: () {
             
             showDialog(context: context,
              builder: (context)=> PlanSelectionDialog()
              );
              },
              child: const SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Get your own Resume',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'See organisations\n Go get the job!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 6,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Center(child: SingleChildScrollView(child: NearbyOrganisations())
                  
                  )
                  ,),
              ),
            )
          ],),
      ),
    );
  }
}