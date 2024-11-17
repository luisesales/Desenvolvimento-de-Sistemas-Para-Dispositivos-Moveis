import 'package:mini_projeto_3/model/pais.dart';
import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AdicionarPais extends StatefulWidget {
  final VoidCallback? onCountryAdded;

  const AdicionarPais({super.key, this.onCountryAdded});

  @override
  State<AdicionarPais> createState() => _AdicionarPaisState();
}

class _AdicionarPaisState extends State<AdicionarPais> {
  final _titleController = TextEditingController();  
  Color _selectedColor = Colors.black;
  bool _wrongTitle = false;
  bool _wrongColor = false;

  void _saveCountry() {
    setState(() {
      if (_titleController.text.isEmpty) {
        _wrongTitle = true;
        return;
      }
      _wrongTitle = false;

      List<Pais> todos_paises = context.read<PaisesModel>().todos_paises;
      for (Pais p in todos_paises) {
        if (_selectedColor == p.cor) {
          _wrongColor = true;
          return;
        }
      }
      _wrongColor = false;

      Provider.of<PaisesModel>(context, listen: false).addPais(Pais(
        id: "c${todos_paises.length + 1}",
        titulo: _titleController.text,
        cor: _selectedColor,
      ));

      if (widget.onCountryAdded != null) {
        widget.onCountryAdded!();
      }

      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar País", style: TextStyle(color: Colors.white)),
        backgroundColor: ThemeData().primaryColor,
        leading: IconButton(
          onPressed: () { Navigator.of(context).pop(); },
          icon: Icon(Icons.arrow_back),
        ),
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
                      "Adicionar País",
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
                        SizedBox(height: 24),
                        Text(
                          'Selecionador de Cor',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ColorPicker(
                          pickerColor: _selectedColor,
                          onColorChanged: (color) {
                            setState(() {
                              _selectedColor = color;
                            });
                          },
                          pickerAreaHeightPercent: 0.8,
                        ),
                        Visibility(
                          visible: _wrongColor,
                          child: Text(
                            "Por favor insira uma cor que não está sendo usada",
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
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: _saveCountry,
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
