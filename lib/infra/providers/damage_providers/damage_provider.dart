// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../../ui/ui.dart';
import '../../infra.dart';

class DamageProvider with ChangeNotifier {
  List<DamageModel> _damageList = [];
  List<DamageModel> get damageList => _damageList;

  List<String> _photos = [];
  List<String> get photos => _photos;

  Future<void> createDamage(
    BuildContext context,
    DamageModel damageModel,
  ) async {
    LoginProvider loginProvider = Provider.of(context, listen: false);

    try {
      final response =
          await http.post(Uri.parse('${Constants.BACKEND_BASE_URL}/navigator/'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${loginProvider.token}',
              },
              body: jsonEncode(damageModel));

      if (response.statusCode == 200) {
        notifyListeners();
      } else if (jsonDecode(response.body)['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          jsonDecode(response.body)['errors'],
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        'Ocorreu um erro ao tentar obter os valores de . $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> showDamages(
    BuildContext context,
    int i,
  ) async {
    LoginProvider loginProvider = Provider.of(context, listen: false);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/navigator/$i'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 200) {
        _damageList = jsonDecode(response.body);
        notifyListeners();
      } else if (jsonDecode(response.body)['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          jsonDecode(response.body)['errors'],
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
      }
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

  Future<void> saveImages(BuildContext context, File file) async {
    try {
      // final response = await http.post(
      //   Uri.parse(''),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Accept': 'application/json',
      //     'Authorization': 'Bearer',
      //   },
      //   body: {
      //     'photo': file,
      //   },
      // );

      // if (response.statusCode == 200) {
      //   _photos.add(jsonDecode(response.body).url);
      //   notifyListeners();
      // } else if (jsonDecode(response.body)['errors'] != '') {
      //   await comumDialog(
      //     context,
      //     'Erro!',
      //     jsonDecode(response.body)['errors'],
      //     () => {
      //       Navigator.of(context).pop(),
      //       notifyListeners(),
      //     },
      //   );
      // }
      _photos.add('imagemX');
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
