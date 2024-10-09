import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {

  DateTime _dataSelecionada = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      //chamada no futuro
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dataSelecionada = pickedDate;
      });
    });
  
  @override
  Widget build(BuildContext context) {
    String? selectedCountry, selectedState;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              Text("Application"),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ],
          ),
          //margin: EdgeInsets.all(4),
        ),
        backgroundColor: Color.fromRGBO(1, 78, 78, 1),
      ),
      body: SingleChildScrollView(child : Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Personal Info",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              margin: EdgeInsets.only(bottom: 16),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Insert a Name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Insert a Name';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(children: <Widget>[
                            Expanded(
                              child: Text(
                                _dataSelecionada == null
                                    ? 'Nenhuma data selecionada'
                                    : 'Data selecionada: ${DateFormat('dd/MM/y').format(_dataSelecionada)}',
                              ),
                            ),
                            TextButton(
                                //style: TextButton.styleFrom(primary: Colors.blue),
                                onPressed: _showDatePicker,
                                child: Text(
                                  'Selecionar Data',
                                ))
                          ]),
                      ),
                      SizedBox(width: 16), 
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Social Security',
                            helperText: '###-##-####'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert a valid value';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              child: Text(
                "Residence Address",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              margin: EdgeInsets.only(bottom: 16, top: 24),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Insert a valid Address';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'City',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert a valid city';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16), // Adiciona um espaço entre os campos
                      Expanded(
                        flex: 2,
                        child: Container(
                            margin: EdgeInsets.only(top: 8),
                            child: DropdownButtonFormField<String>(
                              hint: Text(selectedState ?? "State"),
                              value: selectedState,
                              isExpanded: true,
                              items: ["Rio Grande do Norte","Texas", "Christmas Island"].map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCountry = newValue;
                                });
                              },
                            ),
                          ),
                        ),                
                      ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'ZIP Code',                            
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert a valid ZIP Code';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16), // Adiciona um espaço entre os campos
                      Expanded(                        
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          child: DropdownButtonFormField<String>(
                            hint: Text(selectedCountry ?? "Country"),
                            value: selectedCountry,
                            isExpanded: true,
                            items: ["Brazil","E.U.A", "Australia"].map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCountry = newValue;

                              });
                            },
                          ),
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
