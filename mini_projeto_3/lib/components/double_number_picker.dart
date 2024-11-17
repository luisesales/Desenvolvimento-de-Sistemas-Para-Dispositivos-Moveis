import 'package:flutter/material.dart';

class DoubleNumberPicker extends StatefulWidget { 
  const DoubleNumberPicker({
    super.key,     
    required this.step, 
    required this.precision,
    required this.maxValue,
    required this.minValue,
    required this.labelText,    
    required this.labelIcon,
    required this.onChanged,
  });

  
  final double step; 
  final int precision;
  final double maxValue;
  final double minValue;
  final String labelText;  
  final IconData labelIcon;
  final Function(double) onChanged;

  @override 
  _DoubleNumberPickerState createState() => _DoubleNumberPickerState(); 
} 
class _DoubleNumberPickerState extends State<DoubleNumberPicker> { 
  double _currentValue = 0; 
 _increaseValue() { 
    setState(() {       
      _currentValue = (_currentValue + widget.step).clamp(widget.minValue, widget.maxValue); 
      double? newValue = double.tryParse(_currentValue.toStringAsFixed(widget.precision));
      widget.onChanged(newValue!);
    }); 
  } 
  void _decreaseValue() { 
    setState(() {       
      _currentValue = (_currentValue - widget.step).clamp(widget.minValue, widget.maxValue); 
      double? newValue = double.tryParse(_currentValue.toStringAsFixed(widget.precision));
      widget.onChanged(newValue!);
    }); 
  } 
  @override
  Widget build(BuildContext context) { 
    return Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[ 
            Row(children: [ 
              Icon(widget.labelIcon),
              Text(
                '${widget.labelText} ${_currentValue.toStringAsFixed(widget.precision)}', 
                style: TextStyle(fontSize: 16),), 
               IconButton( 
                  icon: Icon(Icons.remove), 
                  onPressed: _decreaseValue, 
                ), 
                IconButton( 
                  icon: Icon(Icons.add), 
                  onPressed: _increaseValue, 
                ),  
              ],
            ),
            Row( 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [ 
                
              ], 
            ), 
          ], 
        ), 
    );
  }
}