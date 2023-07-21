import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';
import '../../ui.dart';

class CarFormPage extends StatefulWidget {
  const CarFormPage({super.key});

  @override
  State<CarFormPage> createState() => _CarFormPageState();
}

class _CarFormPageState extends State<CarFormPage> {
  String _scanBarcode = '';

  String _brandSelected = 'Marca';
  final List<String> _brandList = ['Mercedez', 'Toyota'];
  String _modelSelected = 'Tipo';
  final List<List<String>> _modelList = [
    ['Tipo', 'Mercedez 1', 'Mercedez 2', 'Mercedez 3', 'Outros'],
    ['Tipo', 'Toyota 1', 'Toyota 2', 'Outros'],
    ['Tipo', 'Outros'],
  ];
  String _embdesSelected = 'Embarque';
  final List<String> _embdesList = ['Embarque', 'Desembarque'];

  TextEditingController brandController = TextEditingController();

  List<DropdownMenuItem<String>> createDropdownBrand(list) {
    return list.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            value,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> createDropdownModel(list) {
    if (_brandList.indexWhere((element) => element == _brandSelected) == 0) {
      return [];
    }
    return list[
            _brandList.indexWhere((element) => element == _brandSelected) - 1]
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.all(15),
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
    _brandList.add('Outros');
    _brandList.insert(0, 'Marca');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> scanBarcodeNormal() async {
      String barcodeScanRes;
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          false,
          ScanMode.BARCODE,
        );
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }

      if (!mounted) return;

      setState(() {
        _scanBarcode = barcodeScanRes;
      });
    }

    DamageProvider damageProvider = Provider.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 15),
            child: Column(
              children: [
                TextButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll<Size?>(Size(
                      (MediaQuery.of(context).size.width * 0.8),
                      75,
                    )),
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.lightBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    scanBarcodeNormal();
                  },
                  child: const Text(
                    'Obter Chassi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Valor do Chassi: $_scanBarcode',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DottedBorder(
                    color: Colors.grey[400]!,
                    strokeWidth: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        itemHeight: 70,
                        value: _brandSelected,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        isExpanded: true,
                        onChanged: (String? value) {
                          setState(() {
                            _brandSelected = value!;
                            _modelSelected = 'Tipo';
                          });
                        },
                        items: createDropdownBrand(_brandList),
                      ),
                    ),
                  ),
                ),
                if (_brandSelected == 'Outros')
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: brandController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.car_rental_outlined),
                        labelText: 'Marca do Carro',
                      ),
                    ),
                  ),
                if (_brandSelected != 'Marca')
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: DottedBorder(
                          color: Colors.grey[400]!,
                          strokeWidth: 1,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              itemHeight: 70,
                              value: _modelSelected,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              isExpanded: true,
                              onChanged: (String? value) {
                                setState(() {
                                  _modelSelected = value!;
                                });
                              },
                              items: createDropdownModel(_modelList),
                            ),
                          ),
                        ),
                      ),
                      if (_modelSelected == 'Outros')
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: brandController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.car_rental_outlined),
                              labelText: 'Modelo do Carro',
                            ),
                          ),
                        ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DottedBorder(
                    color: Colors.grey[400]!,
                    strokeWidth: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        itemHeight: 70,
                        value: _embdesSelected,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        isExpanded: true,
                        onChanged: (String? value) {
                          setState(() {
                            _embdesSelected = value!;
                          });
                        },
                        items: createDropdownBrand(_embdesList),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DottedBorder(
                    color: Colors.grey[400]!,
                    strokeWidth: 1,
                    child: TextButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll<Size?>(Size(
                          (MediaQuery.of(context).size.width * 0.8),
                          80,
                        )),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.FORMDAMAGE);
                      },
                      child: Text(
                        'Adicionar Avaria',
                        style: TextStyle(
                          color: Colors.grey[600]!,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),

                // SOMENTE MOSTRAR SE TIVER AVARIA CADASTRADA:
                if (damageProvider.damageList.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: DottedBorder(
                      color: Colors.grey[400]!,
                      strokeWidth: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 300,
                        child: Column(
                          children: [
                            Text(damageProvider.damageList[0].local),
                            Text(damageProvider.damageList[0].size),
                            Text(damageProvider.damageList[0].type),
                            Text(damageProvider.damageList[0].classification),
                            Row(
                              children: [
                                Text(damageProvider.damageList[0].photos[0]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
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
                    onPressed: () {
                      // Verificar se vai avançar sem avaria
                      // Salvar no Provider
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Finalizar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
