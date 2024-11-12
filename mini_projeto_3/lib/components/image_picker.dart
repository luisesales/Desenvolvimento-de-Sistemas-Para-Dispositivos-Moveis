import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class imagePicker extends StatefulWidget {  
  final Function(String) onImagePicked; 
  
  imagePicker({required this.onImagePicked});

  @override
  _imagePickerState createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.onImagePicked(pickedFile.path);
      } else {
        print('Nenhuma imagem selecionada.');
      }
    });
  }

  void _removeImage() { 
      setState(() { 
        _image = null; 
        widget.onImagePicked("");
      }); 
    }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Imagem',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Column(children: [
                if (_image != null)                   
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(                    
                      onPressed: _removeImage, 
                      icon: Icon(Icons.close)),
                ]),                  
                _image == null
                    ? Text('Nenhuma imagem selecionada.')
                    : Image.file(_image!),
                ],) 
            ),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text('Selecionar da Galeria'),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: Text('Tirar Foto'),
            ),           
          ],
        ),
    );
  }
}
