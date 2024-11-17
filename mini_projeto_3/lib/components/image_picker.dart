import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path; 
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {  
  final Function(String) onImagePicked; 
  
  ImagePickerWidget({required this.onImagePicked});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> { 
  File? _image;

  Future<void> _pickImage(ImageSource source) async { 
    final picker = ImagePicker(); 
    final pickedFile = await picker.pickImage(source: source); 
    final directory = await getApplicationDocumentsDirectory(); 

    if (pickedFile != null) { 
      final fileName = path.basename(pickedFile.path); 
      final customPath = path.join(directory.path, 'assets'); // Defina seu caminho desejado
      final savedImagePath = path.join(customPath, fileName); 

      // Certifique-se de que o diretório customPath exista
      final customDir = Directory(customPath);
      if (!await customDir.exists()) {
        await customDir.create(recursive: true);
      }

      final savedImage = await File(pickedFile.path).copy(savedImagePath); 

      setState(() { 
        _image = savedImage;         
      }); 

      widget.onImagePicked(savedImagePath); 
    } else { 
      print('Nenhuma imagem selecionada.'); 
    } 
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
              child: Column(
                children: [
                  if (_image != null)                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: _removeImage, 
                          icon: Icon(Icons.close)
                        ),
                      ]
                    ),
                  _image == null
                    ? Text('Nenhuma imagem selecionada.')
                    : Image.file(_image!),
                ],
              ) 
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
