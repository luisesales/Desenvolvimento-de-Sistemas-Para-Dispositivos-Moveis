import 'package:mini_projeto_3/components/drawer.dart';
import 'package:mini_projeto_3/components/double_number_picker.dart';
import 'package:mini_projeto_3/components/image_picker.dart';
import 'package:mini_projeto_3/components/dynamic_text_input.dart';
import 'package:mini_projeto_3/model/lugar.dart';
import 'package:numberpicker/numberpicker.dart'; 
import 'package:flutter/material.dart';

class AdicionarLugar extends StatefulWidget {
  const AdicionarLugar({super.key});

@override
  State<AdicionarLugar> createState() => _AdicionarLugarState();
}

class _AdicionarLugarState extends State<AdicionarLugar> {
  @override
  Widget build(BuildContext context) {    
    final _titleController = TextEditingController();
    String? _imageURL; 
    double _avaliation = 0.0; 
    double _cost = 0.0;
    List<TextEditingController> _recomendations = [];
    List<TextEditingController> _countries = [];
    bool _wrongTitle = false;
    bool _wrongPais = false;  
    bool _wrongImage = false;  
    bool _wrongRecomendation = false;  
    bool _wrongAvaliation = false;  
    bool _wrongCost = false;  

    void _updateValue(dynamic newValue, dynamic variable){
      setState(() {
        variable = newValue;
      });
    }

    void _updateList(dynamic newList, dynamic list_variable){
      setState(() {
        list_variable.clear();
        for(dynamic o in newList){
          list_variable.add(o);
        }
      });
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lugares",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeData().primaryColor,
      ),
      drawer: MeuDrawer(),
      body: SingleChildScrollView(child : Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Adicionar Lugar",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              margin: EdgeInsets.only(bottom: 16),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Título',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira um título';
                      }
                      return null;
                    },
                  ),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4.0,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Expanded(
                            child: DoubleNumberPicker(
                              step: 0.1, 
                              precision: 1,
                              maxValue: 5,
                              minValue: 0,
                              labelText: '', 
                              labelIcon: Icons.star,
                              onChanged: (double){_updateValue(double,_avaliation);}
                              )
                          ),                                                    
                        ),
                        Expanded(
                          flex: 2,
                          child: Expanded(
                            child: DoubleNumberPicker(
                              step: 5, 
                              precision: 2,
                              maxValue: double.infinity,
                              minValue: 0,
                              labelText: 'Custo :',
                              labelIcon: Icons.attach_money,
                              onChanged: (double){_updateValue(double,_cost);}
                              )
                          ),                                                    
                        ), 
                        Container(
                          margin: EdgeInsets.only(top: 16, bottom: 16),
                          child: imagePicker(onImagePicked: (String){_updateValue(String,_imageURL);},)   
                        ),                           
                        DynamicTextInput(
                          label : "Recomendação",
                          onChanged: (dynamic){
                            _updateList(dynamic, _recomendations);
                          },
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ]),
        )
      )
    );
  }
}
