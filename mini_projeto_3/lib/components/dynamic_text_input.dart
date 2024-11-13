import 'package:flutter/material.dart';

class DynamicTextInput extends StatefulWidget {

  final Function(List<TextEditingController>) onChanged; 
  final String label;
  
  DynamicTextInput({
    required this.label,
    required this.onChanged,
  });


  @override
  _DynamicTextInputState createState() => _DynamicTextInputState();
}

class _DynamicTextInputState extends State<DynamicTextInput> {
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _addTextField(); // Adiciona um campo de texto inicial      
  }

  void _addTextField() {
    setState(() {
      _controllers.add(TextEditingController());
      widget.onChanged(_controllers);
    });
  }

  void _removeTextField(int index){
    setState(() {
      _controllers.remove(_controllers[index]);
      widget.onChanged(_controllers);
    });
  }

  @override
  void dispose() {
    // Dispose de todos os controladores para liberar recursos
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(  
      height: 200,      
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Flex(
                    direction: Axis.vertical,
                    children:[ 
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                controller: _controllers[index],
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
