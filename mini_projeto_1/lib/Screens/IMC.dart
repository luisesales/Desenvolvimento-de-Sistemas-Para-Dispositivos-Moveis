import 'package:flutter/material.dart';
import 'package:mini_projeto_1/Screens/cubeLayout.dart';
import 'package:mini_projeto_1/Screens/forms.dart';
import 'package:mini_projeto_1/customCard.dart';

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
  String _category = '';
  Color _backgroundColor = Colors.black;
  Color _textColor = Colors.white;
  bool _isVisible = false;

  

  CalcularIMC(){
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text);
    setState(() {
      _imcController = (weight / (height * height));    
    });                   
    _isVisible = true;
    if(_imcController < 18.5){ 
      _backgroundColor = const Color.fromARGB(255, 94, 169, 231);
      _category = 'Underweight';      
      _imageURL = 'assets/images/underweight.png';
    }
    else if(_imcController < 25) {
      _backgroundColor = const Color.fromARGB(255, 150, 187, 65);
      _category = 'Normal Weight';      
      _imageURL = 'assets/images/normalweight.png';
    }
    else if(_imcController < 30) {
      _backgroundColor = const Color.fromARGB(255, 247, 228, 64);
      _category = 'Overweight';   
      _imageURL = 'assets/images/overweight.png';

    }
    else if(_imcController < 40) {
      _backgroundColor = const Color.fromARGB(255, 255, 145, 0);
      _category = 'Obesity';   
      _imageURL = 'assets/images/obesity.png';
    }
    else {
      _backgroundColor = const Color.fromARGB(255, 230, 46, 0);
      _category = 'Extreme Obesity';   
      _imageURL = 'assets/images/extremeobesity.png';
    }
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
              IconButton(onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Forms()));
              }, icon: Icon(Icons.arrow_back)),
              Spacer(),
              Text("IMC Calculator"),
              Spacer(),
              IconButton(onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CubeLayout()),
            );

              }, icon: Icon(Icons.arrow_forward)),
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
                    Visibility(
                    visible: _isVisible,                    
                      child : Column( 
                        children: [
                          Container(
                            child: Center(
                              child: SizedBox(
                                width: _imgWidth,                 
                                height: _imgHeight,
                                child: Image.asset(_imageURL),                  
                              ),  
                            ),
                          ),
                          Container(                      
                            child: CustomCard(backgroundColor: _backgroundColor, textColor: _textColor, category: _category, imcValue: _imcController),
                          )
                        ]
                      )
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
