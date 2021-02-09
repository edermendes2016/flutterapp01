import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

//controllers
class HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String infoText = "PREENCHA OS CAMPOS";

  void resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "PREENCHA OS CAMPOS";
      formKey = GlobalKey<FormState>();
    });
  }

//Regras do calculo
  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);

      double resultIMC = weight / (height * height);

      if (resultIMC >= 20.0 && resultIMC <= 24.9) {
        infoText = "PESO NORMAL (${resultIMC.toStringAsPrecision(4)})";
      } else if (resultIMC < 19.9) {
        infoText = "PESO MAGROLA (${resultIMC.toStringAsPrecision(4)})";
      } else {
        infoText = "PESO GORDOLA (${resultIMC.toStringAsPrecision(4)})";
      }
    });
  }

//view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              resetField();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_rounded, size: 100.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "PESO (KG)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 30.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "COLOQUE SEU PESO (KG).";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "ALTURA (KG)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 30.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "COLOQUE SUA ALTURA.";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 45.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        calculate();
                      }
                    },
                    child: Text(
                      "CALCULAR",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
