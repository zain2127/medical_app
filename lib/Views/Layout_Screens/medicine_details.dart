import 'package:flutter/material.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final String drugName;
  final String dosageForm;
  final String dosageStrength;
  final String contraindications;
  final String sideEffects;
  final String storage;
  final String imageUrl;
  final String indications;

  MedicineDetailsScreen({
    required this.drugName,
    required this.dosageForm,
    required this.dosageStrength,
    required this.contraindications,
    required this.sideEffects,
    required this.storage,
    required this.imageUrl,
    required this.indications,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drugName),
        backgroundColor: Colors.orange[200],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.network(imageUrl,fit: BoxFit.fill,)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dosage Form:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange
                    ),
                  ),
                  Text(
                    dosageForm,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Dosage Strength:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                        color: Colors.orange
                    ),
                  ),
                  Text(
                    dosageStrength,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Contraindications:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                        color: Colors.orange
                    ),
                  ),
                  Text(
                    contraindications,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Indications:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange
                    ),
                  ),
                  Text(
                    indications,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Side Effects:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                        color: Colors.orange
                    ),
                  ),
                  Text(
                    sideEffects,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Storage:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                        color: Colors.orange
                    ),
                  ),
                  Text(
                    storage,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}