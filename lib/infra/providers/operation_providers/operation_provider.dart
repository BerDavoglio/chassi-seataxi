// ignore_for_file: use_build_context_synchronously

import 'dart:async';
// import 'dart:convert';

// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../infra.dart';

class OperationProvider with ChangeNotifier {
  String _operationCode = '';
  String get operationCode => _operationCode;

  Future<void> changeOperationCode(BuildContext context, String code) async {
    try {
      _operationCode = code;
      notifyListeners();
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        'Ocorreu um erro ao tentar obter os valores de configuração de Navegador. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }
}
