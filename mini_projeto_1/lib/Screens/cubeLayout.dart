import 'package:flutter/material.dart';
import 'package:mini_projeto_1/Screens/IMC.dart';
import 'package:mini_projeto_1/Screens/forms.dart';

class CubeLayout extends StatelessWidget {
  const CubeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => IMC()));
              }, icon: Icon(Icons.arrow_back)),
              Spacer(),
              Text("Cube Layout"),
              Spacer(),
              IconButton(onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Forms()),
            );

              }, icon: Icon(Icons.arrow_forward)),
            ],
          ),
          //margin: EdgeInsets.all(4),
        ),
        backgroundColor: Color.fromRGBO(1, 78, 78, 1),
      ),
      body: SingleChildScrollView(child : Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(                  
                  height: 100,
                  color:  Colors.red[600],
                ),                
              ),
              Expanded(
                flex: 1,                
                child: Container(                  
                  height: 100,
                  color:  Colors.green[600],
                ),                
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(                  
                  height: 100,
                  color:  Colors.red[600],
                ),                
              ),
              Expanded(
                flex: 1,                
                child: Container(                  
                  height: 100,
                  color:  Colors.blue[900],
                ),                
              ),
              Expanded(
                flex: 1,                
                child: Container(                  
                  height: 100,
                  color:  Colors.yellow,
                ),                
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(                  
                  height: 100,
                  color:  Colors.red[600],
                ),                
              ),
              Expanded(
                flex: 1,                
                child: Container(                  
                  height: 100,
                  color:  Colors.green[600],
                ),                
              ),
              Expanded(
                flex: 2,                
                child: Container(                  
                  height: 100,
                  color:  Colors.yellow,
                ),                
              )
            ],
          ),
          Row(
            children: [              
              Expanded(
                flex: 1,                
                child: Container(                  
                  height: 100,
                  color:  Colors.blue[900],
                ),                
              ),
              Expanded(
                flex: 3,                
                child: Container(                  
                  height: 100,
                  color:  Colors.yellow,
                ),                
              )
            ],
          ),
          Row(
            children: [              
              Expanded(
                flex: 2,                
                child: Container(                  
                  height: 100,
                  color:  Colors.green[600],
                ),                
              ),
              Expanded(
                flex: 1,
                child: Container(                  
                  height: 100,
                  color:  Colors.red[600],
                ),                
              ),
              Expanded(
                flex: 1,                
                child: Container(                  
                  height: 100,
                  color:  Colors.yellow,
                ),                
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(                  
                  height: 100,
                  color:  Colors.green[600],
                ),                
              ),
              Expanded(
                flex: 1,                
                child: Container(                  
                  height: 100,
                  color:  Colors.blue[900],
                ),                
              )
            ],
          ),
        ],
      )
    )
    );    
  }
}