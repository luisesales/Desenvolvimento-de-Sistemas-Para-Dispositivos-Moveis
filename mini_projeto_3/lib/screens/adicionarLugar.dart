import 'package:mini_projeto_3/components/drawer.dart';
import 'package:mini_projeto_3/components/double_number_picker.dart';
import 'package:mini_projeto_3/components/image_picker.dart';
import 'package:mini_projeto_3/components/dynamic_text_input.dart';
import 'package:mini_projeto_3/components/dynamic_dropdown_list.dart';
import 'package:mini_projeto_3/model/lugar.dart';
import 'package:mini_projeto_3/model/pais.dart';
import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdicionarLugar extends StatefulWidget {
  const AdicionarLugar({super.key});

@override
  State<AdicionarLugar> createState() => _AdicionarLugarState();
}

class _AdicionarLugarState extends State<AdicionarLugar> {

  

  @override
  Widget build(BuildContext context) {   
    List<Lugar> todos_lugares = context.watch<PaisesModel>().todos_lugares;
    List<Pais> todos_paises = context.watch<PaisesModel>().todos_paises;
    final _titleController = TextEditingController();
    String? _imageURL; 
    double _avaliation = 0.0; 
    double _cost = 0.0;
    List<TextEditingController> _recomendations = [];
    List<String> _countries = [];
    bool _wrongTitle = false;
    bool _wrongPais = false;  
    bool _wrongImage = false;  
    bool _wrongRecomendation = false;      

    void _updateValue(dynamic newValue, dynamic variable){
      setState(() {
        variable = newValue;
      });
    }

    void _saveUser(){
    setState(() {
      if(_titleController.text.isEmpty){
        _wrongTitle = true;
        return;
      }
      if(_imageURL!.isEmpty ||
       (todos_lugares.any((lugar) => (lugar.imagemUrl == _imageURL))) 
       ){
        _wrongImage = true;
        return;
      } 
      for(TextEditingController t in _recomendations){
        if(t.text.isEmpty){
          _wrongRecomendation = true;
          return;
        }
      }
      if(_countries.isEmpty){
        _wrongPais = true;
        return;
      }
      List<String> countriesIds = [];
      for(String s in _countries){
        String countryId = todos_paises.firstWhere((pais) => pais.titulo == s).id;
        if(!countriesIds.contains(countryId)){
          countriesIds.add(countryId);
        }
      }
      List<String> formatRecomendations = [];
      int index = 1;
      for(TextEditingController t in _recomendations){
        formatRecomendations.add("${index++}. ${t.text}");
      }
      Provider.of<PaisesModel>(context).addLugar(Lugar(
        id: "p${todos_lugares.length+1}", 
        paises: countriesIds, 
        titulo: _titleController.text, 
        imagemUrl: _imageURL, 
        recomendacoes: formatRecomendations, 
        avaliacao: _avaliation, 
        custoMedio: _cost)
      );
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
      body: Stack(children: [ 
        SingleChildScrollView(child : Container(
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
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),                  
                    ),
                    Visibility(
                      visible: _wrongTitle, 
                      child: Text(
                          "Por favor insira um título",
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 8,
                        ),
                      ),
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
                          Visibility(
                            visible: _wrongImage, 
                            child: Text(
                                "Por favor insira uma imagem não registrada",
                                style: TextStyle(
                                  color: Colors.red[600],
                                  fontSize: 8,
                              ),
                            ),
                          ),                             
                          DynamicTextInput(
                            title: "Recomendações",
                            label : "Recomendação",                          
                            controllers: _recomendations,
                          ),
                          Visibility(
                            visible: _wrongRecomendation, 
                            child: Text(
                                "Por favor insira uma recomendação",
                                style: TextStyle(
                                  color: Colors.red[600],
                                  fontSize: 8,
                              ),
                            ),
                          ),                             
                          DynamicDropdownList(
                            title: "Países",
                            label: "País",
                            selectedList: _countries,
                            list: todos_paises.map((pais) => pais.titulo).toList(),    
                          ),
                          Visibility(
                            visible: _wrongPais, 
                            child: Text(
                                "Por favor insira um país",
                                style: TextStyle(
                                  color: Colors.red[600],
                                  fontSize: 8,
                              ),
                            ),
                          ),                                
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ]),
          )
        ),
        Positioned( 
          bottom: 16, 
          right: 16, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: _saveUser,                  
                tooltip: 'Salvar Dados',

                child: Icon(Icons.save),
              ),
          ],),
        ),      
      ]),
    );  
  }
}
