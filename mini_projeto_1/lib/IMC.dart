import 'package:flutter/material.dart';

class IMC extends StatefulWidget {
  const IMC({super.key});

  @override
  State<IMC> createState() => _IMCState();
}

class _IMCState extends State<IMC> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _imcController = "0.0";

  CalcularIMC(){
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text);
    setState(() {
      _imcController = (weight / (height * height)).toString();
    });    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              Spacer(),
              Text("IMC Calculator"),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
            ],
          ),
          //margin: EdgeInsets.all(4),
        ),
        backgroundColor: Color.fromRGBO(1, 78, 78, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Data",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.only(bottom: 16),
              ),
              Form(
                child: Column( 
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _heightController,
                            decoration: InputDecoration(
                              labelText: 'Height',
                              helperText: 'X.XXm'
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please insert a valid height';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 16), 
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _weightController,
                            decoration: InputDecoration(
                              labelText: 'Weight',
                              helperText: 'XX.Xkg'
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please insert a valid weight';
                              }
                              return null;
                            },
                          ),
                        )
                      ], 
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                        onPressed: CalcularIMC,                        
                        child: Text("Calcular", style: TextStyle(fontSize: 16)),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: Text(_imcController, style: TextStyle(fontSize: 16)),
                    ),                    
                  ]              
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
