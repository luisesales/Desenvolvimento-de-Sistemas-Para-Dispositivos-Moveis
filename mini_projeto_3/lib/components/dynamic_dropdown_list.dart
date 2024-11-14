import 'package:flutter/material.dart';
import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:provider/provider.dart';

class DynamicDropdownList extends StatefulWidget {
  
  String label;
  List<String?> selectedCountries;
    
  DynamicDropdownList({
    required this.label,
    required this.selectedCountries,        
  });


  @override
  _DynamicDropdownListState createState() => _DynamicDropdownListState();
}

class _DynamicDropdownListState extends State<DynamicDropdownList> {
  

  @override
  void initState() {
    super.initState();
    _addField(); // Adiciona um campo de texto inicial      
  }

  void _addField() {
    setState(() {
      widget.selectedCountries.add("");      
    });
  }

  void _removeField(int index){
    setState(() {            
      widget.selectedCountries.remove(widget.selectedCountries[index]);      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(  
      height: 200,      
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: widget.selectedCountries.length,
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
                              child: DropdownButtonFormField<String>(
                                hint: Text(widget.selectedCountries[index] ?? "País ${index+1}"),
                                value: widget.selectedCountries[index],
                                isExpanded: true,
                                items: context.read<PaisesModel>().todos_paises .map(
                                  (pais) => DropdownMenuItem<String>( 
                                    value: pais.titulo, child: Text(pais.titulo), 
                                  ),
                                ).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    widget.selectedCountries[index] = newValue;
                                  });
                                },
                              ),
                            ),                                                        
                            Expanded(
                              flex: 1,
                              child: IconButton(                                
                                onPressed: (){_removeField(index);}, 
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
                    onPressed: _addField,                  
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

