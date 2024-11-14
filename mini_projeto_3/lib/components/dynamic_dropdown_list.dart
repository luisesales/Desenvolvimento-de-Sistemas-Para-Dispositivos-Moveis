import 'package:flutter/material.dart';
import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:mini_projeto_3/model/pais.dart';
import 'package:provider/provider.dart';
import 'package:mini_projeto_3/model/PaisesModel.dart';

class DynamicDropdownList extends StatefulWidget {
  final String title;
  final String label;
  List<String?> selectedCountries;
    
  DynamicDropdownList({
    required this.title,
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
    List<String> availableCountries = context.read<PaisesModel>().todos_paises.map((pais) => pais.titulo).toList();    
    return Container(  
      height: 200,      
      margin: EdgeInsets.only(top: 36),
        child: Column(
          children: <Widget>[
            Text(
              '${widget.title}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
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
                                value: availableCountries.first,
                                isExpanded: true,
                                items: availableCountries.map((title){ 
                                  return DropdownMenuItem<String>( 
                                    value: title, child: Text(title), 
                                  );
                                  }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    if(!availableCountries.contains(widget.selectedCountries[index])){
                                      availableCountries.add(widget.selectedCountries[index]!);
                                    }
                                    widget.selectedCountries[index] = newValue;
                                    availableCountries.remove(newValue);
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
                        ],
                      ),                    
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

