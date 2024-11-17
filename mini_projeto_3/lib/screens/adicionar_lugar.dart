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
  final VoidCallback? onPlaceAdded;
  const AdicionarLugar({super.key,this.onPlaceAdded});

  @override
  State<AdicionarLugar> createState() => _AdicionarLugarState();
}

class _AdicionarLugarState extends State<AdicionarLugar> {
  final _titleController = TextEditingController();
  String? _imageURL = ""; 
  double _avaliation = 0.0; 
  double _cost = 0.0;
  List<TextEditingController> _recomendations = [];
  List<String> _countries = [];
  bool _wrongTitle = false;
  bool _wrongPais = false;  
  bool _wrongImage = false;  
  bool _wrongRecomendation = false;  

  void _updateImageURL(String newImageURL) { 
    setState(() { 
      _imageURL = newImageURL; 
    }); 
  }

  void _updateCost(double value){
    setState(() {
      _cost = value;
    });
  }

  void _updateAvaliation(double value){
    setState(() {
      _avaliation = value;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    List<Lugar> todos_lugares = context.read<PaisesModel>().todos_lugares;
    List<Pais> todos_paises = context.read<PaisesModel>().todos_paises; 

    void _savePlace() {
    setState(() {
      _wrongTitle = _titleController.text.isEmpty;
      _wrongPais = _countries.isEmpty;
      _wrongImage = _imageURL == "" || todos_lugares.any((lugar) => lugar.imagemUrl == _imageURL);
      _wrongRecomendation = _recomendations.any((controller) => controller.text.isEmpty);

      if (_wrongTitle || _wrongPais || _wrongImage || _wrongRecomendation) {
        return;
      }

      List<String> countriesIds = _countries.map((country) {
        return todos_paises.firstWhere((pais) => pais.titulo == country).id;
      }).toList();

      List<String> formatRecomendations = _recomendations.asMap().entries.map((entry) {
        return "${entry.key + 1}. ${entry.value.text}";
      }).toList();

      Provider.of<PaisesModel>(context, listen: false).addLugar(Lugar(
        id: "p${todos_lugares.length + 1}", 
        paises: countriesIds, 
        titulo: _titleController.text, 
        imagemUrl: _imageURL!, 
        recomendacoes: formatRecomendations, 
        avaliacao: _avaliation, 
        custoMedio: _cost
      ));

      if (widget.onPlaceAdded != null) {
        widget.onPlaceAdded!();
      }

      Navigator.of(context).pop();
    });    
  }    

    return Scaffold(
      appBar: AppBar(
        title: Text("Lugares", style: TextStyle(color: Colors.white)),
        backgroundColor: ThemeData().primaryColor,
      ),      
      body: Stack(
        children: [ 
          SingleChildScrollView(
            child: Container(
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
                                child: DoubleNumberPicker(
                                  step: 0.1,
                                  precision: 1,
                                  maxValue: 5,
                                  minValue: 0,
                                  labelText: '', 
                                  labelIcon: Icons.star,
                                  onChanged: (double value) {
                                    _updateAvaliation(value);
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: DoubleNumberPicker(
                                  step: 5, 
                                  precision: 2,
                                  maxValue: double.infinity,
                                  minValue: 0,
                                  labelText: 'Custo :',
                                  labelIcon: Icons.attach_money,
                                  onChanged: (double value) {
                                    _updateCost(value);
                                  },
                                ),                                                    
                              ), 
                              Container(
                                margin: EdgeInsets.only(top: 16, bottom: 16),
                                child: ImagePickerWidget(
                                  onImagePicked: (String value) {
                                    _updateImageURL(value);
                                  },
                                ),
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
                                label: "Recomendação",
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: _savePlace,
                  tooltip: 'Salvar Dados',
                  child: Icon(Icons.save),
                ),
              ],
            ),
          ),
        ],
      ),
    );  
  }
}
