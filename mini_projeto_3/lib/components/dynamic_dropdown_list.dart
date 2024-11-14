import 'package:flutter/material.dart';

class DynamicDropdownList extends StatefulWidget {
  final String title;
  final String label;
  List<String?> selectedList;
  final List<String?> list;
    
  DynamicDropdownList({
    required this.title,
    required this.label,
    required this.selectedList,      
    required this.list,  
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
      if(widget.selectedList.length < widget.list.length)
        widget.selectedList.add(widget.list.first);      
    });
  }

  void _removeField(int index){
    setState(() {            
      widget.selectedList.remove(widget.selectedList.elementAt(index));      
    });
  }

  @override
  Widget build(BuildContext context) {    
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
                itemCount: widget.selectedList.length,
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
                                hint: Text(widget.selectedList[index] ?? "País ${index+1}"),
                                value: widget.selectedList[index],
                                isExpanded: true,
                                items: widget.list.map((title){ 
                                  return DropdownMenuItem<String>( 
                                    value: title, child: Text(title!), 
                                  );
                                  }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {                                    
                                    widget.selectedList[index] = newValue;                                    
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

