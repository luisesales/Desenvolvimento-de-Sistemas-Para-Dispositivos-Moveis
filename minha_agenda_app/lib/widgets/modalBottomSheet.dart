import 'package:mini_projeto_3/model/lugar.dart';
import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalBottomSheet extends StatelessWidget {
  final VoidCallback onConditionMet;
  final String confirmLabel;
  final String confirmTitle;
  final String confirmAction;
  final Color color;
  const ModalBottomSheet({
    super.key,
    required this.onConditionMet,
    required this.confirmLabel,
    required this.confirmTitle,
    required this.confirmAction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '${confirmTitle}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text('${confirmLabel}'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Spacer(),
              ElevatedButton(
                child: Text('${confirmAction}'),
                style:
                    ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
                onPressed: () {
                  if (true) {
                    onConditionMet();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
