import 'package:flutter/material.dart';

class Forms extends StatelessWidget {
  const Forms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
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
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Birthday',
                            helperText: 'DD/MM/YYYY'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert a valid value';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16), // Adiciona um espaço entre os campos
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
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'State',                            
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert a valid state';
                            }
                            return null;
                          },
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
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Countrt',                            
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert a valid Country';
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
          ],
        ),
      ),
    );
  }
}
