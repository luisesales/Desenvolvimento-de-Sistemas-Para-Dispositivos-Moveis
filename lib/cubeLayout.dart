import 'package:flutter/material.dart';

class CubeLayout extends StatelessWidget {
  const CubeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
    );
    
  }
}