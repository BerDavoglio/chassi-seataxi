import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:front/infra/infra.dart';
import 'package:provider/provider.dart';

import '../ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Future<void> scanQR() async {
      OperationProvider operationProvider = Provider.of(context, listen: false);
      String barcodeScanRes;

      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancelar',
          false,
          ScanMode.QR,
        );
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }

      if (!mounted) return;

      setState(() async {
        await operationProvider.changeOperationCode(context, barcodeScanRes);
      });
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: ButtonStyle(
                  fixedSize:
                      const MaterialStatePropertyAll<Size?>(Size(300, 100)),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.lightBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(15),
                ),
                onPressed: () {
                  // scanQR();
                  Navigator.of(context).pushNamed(AppRoutes.FORMCARLIST);
                },
                child: const Text(
                  'Começar Operação',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
