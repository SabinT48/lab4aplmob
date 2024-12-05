import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}



class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  String gender = 'male';
  double weight = 70;
  int age = 23;
  double height = 170;
  double? bmi;

  void calculateBMI() {
    setState(() {
      bmi = weight / ((height / 100) * (height / 100));
    });
  }

  String getBMICategory() {
    if (bmi == null) return '';
    if (bmi! < 18.5) return 'Subponderal';
    if (bmi! < 25) return 'Normal';
    if (bmi! < 30) return 'Supraponderal';
    return 'Obez';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator IMC'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bine ai venit',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => gender = 'male'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      gender == 'male' ? Colors.blue : Colors.grey[300],
                    ),
                    child: Text('♂ Bărbat'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => gender = 'female'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      gender == 'female' ? Colors.blue : Colors.grey[300],
                    ),
                    child: Text('♀ Femeie'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildInputBox('Greutate (kg)', weight.toString(), (value) {
                    setState(() => weight = double.tryParse(value) ?? weight);
                  }, (delta) {
                    setState(() => weight += delta);
                  }),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildInputBox('Vârstă (ani)', age.toString(), (value) {
                    setState(() => age = int.tryParse(value) ?? age);
                  }, (delta) {
                    setState(() => age += delta.toInt());
                  }),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildInputBox('Înălțime (cm)', height.toString(), (value) {
              setState(() => height = double.tryParse(value) ?? height);
            }, null),
            SizedBox(height: 20),
            if (bmi != null)
              Column(
                children: [
                  Text(
                    bmi!.toStringAsFixed(1),
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  Text(
                    getBMICategory(),
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Să începem', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox(String label, String value, Function(String) onChanged,
      Function(double)? onDelta) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label),
        TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        if (onDelta != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => onDelta(-1),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => onDelta(1),
              ),
            ],
          ),
      ],
    );
  }
}
