// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:front/ui/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../../infra/infra.dart';

class BreakDownFormPage extends StatefulWidget {
  const BreakDownFormPage({super.key});

  @override
  State<BreakDownFormPage> createState() => _BreakDownFormPageState();
}

class _BreakDownFormPageState extends State<BreakDownFormPage> {
  String _localSelected = 'Capo';
  final List<String> _localList = [
    'Capo',
    'Porta 1',
    'Porta 2',
    'Porta 3',
    'Porta 4',
    'Porta Malas',
    'Para choque 1',
    'Para choque 2',
  ];
  String _typeSelected = 'Corte';
  final List<String> _typeList = [
    'Corte',
    'Riscado',
    'Batida',
  ];
  final TextEditingController _typeController = TextEditingController();
  String _sizeSelected = 'até 3cm';
  final List<String> _sizeList = [
    'até 3cm',
    'de 3cm até 15cm',
    'de 15cm até 30cm',
    'mais que 30cm',
  ];
  String _classificationSelected = 'Classificação 1';
  final List<String> _classificationList = [
    'Classificação 1',
    'Classificação 2',
    'Classificação 3',
    'Classificação 4',
    'Classificação 5',
    'Classificação 6',
  ];

  List<File> imageFileList = [];

  Future<void> _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    setState(() {
      imageFileList.add(File(pickedFile!.path));
    });
  }

  List<DropdownMenuItem<String>> createDropdown(list) {
    return list.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: Text(
            value,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    _typeList.add('Outros');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DamageProvider damageProvider = Provider.of(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 15),
            child: Column(children: [
              Row(
                children: [
                  Text('Local da Avaria:',
                      style: TextStyle(color: Colors.indigo[800]!)),
                ],
              ),
              DottedBorder(
                color: Colors.grey[400]!,
                strokeWidth: 1,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    itemHeight: 70,
                    value: _localSelected,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (String? value) {
                      setState(() {
                        _localSelected = value!;
                      });
                    },
                    items: createDropdown(_localList),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Tipo da Avaria:',
                            style: TextStyle(color: Colors.indigo[800]!)),
                      ],
                    ),
                    DottedBorder(
                      color: Colors.grey[400]!,
                      strokeWidth: 1,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          itemHeight: 70,
                          value: _typeSelected,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          isExpanded: true,
                          onChanged: (String? value) {
                            setState(() {
                              _typeSelected = value!;
                            });
                          },
                          items: createDropdown(_typeList),
                        ),
                      ),
                    ),
                    if (_typeSelected == 'Outros')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _typeController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.car_rental_outlined),
                            labelText: 'Tipo de Avaria',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text('Tamanho da Avaria:',
                        style: TextStyle(color: Colors.indigo[800]!)),
                  ],
                ),
              ),
              DottedBorder(
                color: Colors.grey[400]!,
                strokeWidth: 1,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    itemHeight: 70,
                    value: _sizeSelected,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (String? value) {
                      setState(() {
                        _sizeSelected = value!;
                      });
                    },
                    items: createDropdown(_sizeList),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text('Tamanho da Avaria:',
                        style: TextStyle(color: Colors.indigo[800]!)),
                  ],
                ),
              ),
              DottedBorder(
                color: Colors.grey[400]!,
                strokeWidth: 1,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    itemHeight: 70,
                    value: _classificationSelected,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (String? value) {
                      setState(() {
                        _classificationSelected = value!;
                      });
                    },
                    items: createDropdown(_classificationList),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Column(
                  children: [
                    if (imageFileList.length <= 2)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7.5),
                        child: TextButton(
                          style: ButtonStyle(
                            elevation:
                                const MaterialStatePropertyAll<double>(10),
                            fixedSize: MaterialStatePropertyAll<Size?>(Size(
                              (MediaQuery.of(context).size.width * 0.75),
                              60,
                            )),
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () => _getFromCamera(),
                          child: const Text(
                            'Tirar Fotos',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (imageFileList.isNotEmpty)
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.file(imageFileList[0]),
                          ),
                        if (imageFileList.length > 1)
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.file(imageFileList[1]),
                          ),
                        if (imageFileList.length > 2)
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.file(imageFileList[2]),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll<Size?>(Size(
                    (MediaQuery.of(context).size.width * 0.4),
                    75,
                  )),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (imageFileList.isNotEmpty) {
                    for (File f in imageFileList) {
                      await damageProvider.saveImages(context, f);
                    }
                  }
                  await damageProvider
                      .createDamage(
                          context,
                          DamageModel(
                            local: _localSelected,
                            type: _typeSelected != "Outros"
                                ? _typeSelected
                                : _typeController.text,
                            size: _sizeSelected,
                            classification: _classificationSelected,
                            photos: damageProvider.photos,
                          ))
                      .then((value) => Navigator.of(context).pop());
                },
                child: const Text(
                  'Finalizar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
