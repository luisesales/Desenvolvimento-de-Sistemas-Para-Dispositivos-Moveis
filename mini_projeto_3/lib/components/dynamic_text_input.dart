import 'package:flutter/material.dart';

class DynamicTextInput extends StatefulWidget {
  
  final String label;
  List<TextEditingController> controllers;
  
  DynamicTextInput({
    required this.label,    
    required this.controllers,
  });


  @override
  _DynamicTextInputState createState() => _DynamicTextInputState();
}

class _DynamicTextInputState extends State<DynamicTextInput> {
  

  @override
  void initState() {
    super.initState();
    _addTextField(); // Adiciona um campo de texto inicial      
  }

  void _addTextField() {
    setState(() {
      widget.controllers.add(TextEditingController());      
    });
  }

  void _removeTextField(int index){
    setState(() {
      widget.controllers[index].dispose();
      widget.controllers.remove(widget.controllers[index]);      
    });
  }

  @override
  void dispose() {
    // Dispose de todos os controladores para liberar recursos
    for (var controller in widget.controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(  
      margin: EdgeInsets.only(top: 8),
      height: 200,      
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: widget.controllers.length,
                itemBuilder: (context, index) {
                  return Flex(
                    direction: Axis.vertical,
                    children:[ 
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                controller: widget.controllers[index],
                                decoration: InputDecoration(                        
                                  labelText: '${widget.label}: ${index + 1}',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(                                
                                onPressed: (){_removeTextField(index);}, 
                                icon: const Icon(Icons.close),
                              ),
                            ),
                        ],)
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(              
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: _addTextField,                  
                    tooltip: 'Adicionar Campo de Texto',

                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      );    
  }
}
