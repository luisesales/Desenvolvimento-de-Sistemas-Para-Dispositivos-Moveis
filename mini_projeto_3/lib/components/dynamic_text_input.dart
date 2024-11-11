import 'package:flutter/material.dart';

class DynamicTextInput extends StatefulWidget {
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _controllers.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _controllers[index],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Campo de Texto ${index + 1}',
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _addTextField,
                child: Icon(Icons.add),
                tooltip: 'Adicionar Campo de Texto',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
