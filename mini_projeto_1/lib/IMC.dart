import 'package:flutter/material.dart';

class IMC extends StatefulWidget {
  const IMC({super.key});

  @override
  State<IMC> createState() => _IMCState();
}

class _IMCState extends State<IMC> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();  
  double  _imcController = 0;
  String _imageURL = '';

  

  CalcularIMC(){
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text);
    setState(() {
      _imcController = (weight / (height * height));
      if(_imcController < 18.5){ _imageURL = './assets/underweight.png';}
      if(_imcController < 25) {_imageURL = './assets/normalweight.png';}
      if(_imcController < 30) {_imageURL = './assets/overweight.png';}
      if(_imcController < 35) {_imageURL = './assets/obesity.png';}
      else {_imageURL = './assets/extremeobesity.png';}
    });    
  }

  @override
  Widget build(BuildContext context) {
    double _imgWidth = MediaQuery.of(context).size.width * 0.8;
    double _imgHeight = _imgWidth*3;
    
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
                      child: Center(
                        child: SizedBox(
                          width: _imgWidth,                 
                          height: _imgHeight,
                          child: Image.asset(_imageURL),                  
                        ),  
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: Text(_imcController.toString(), style: TextStyle(fontSize: 16)),
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
