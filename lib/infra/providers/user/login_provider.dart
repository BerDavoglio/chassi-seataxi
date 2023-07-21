// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../data/data.dart';
import '../../../ui/ui.dart';
import '../../infra.dart';

class LoginProvider with ChangeNotifier {
  String _token = '';
  late UserModel _perfil;

  String get token => _token;
  UserModel get perfil => _perfil;

  bool get isAuth {
    return _token != '';
  }

  Future<void> submitLogin(
      BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/jwt/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      var v = jsonDecode(response.body);

      if (v['token'] != '') {
        _token = v['token'];
        await requestPerfil(context);
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
        notifyListeners();
      } else if (v['errors'] != '') {
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
        'Coloque o e-mail e a senha corretos por gentileza. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> requestPerfil(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/user/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        _perfil = jsonDecode(response.body);
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
        'Ocorreu um erro ao tentar obter os valores de perfil. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> updatePerfil(BuildContext context, UserModel newUser) async {
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/user/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(newUser),
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await comumDialog(
          context,
          'Usuário Atualizado',
          'Usuário atualizado com Sucesso!',
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
        await requestPerfil(context);
        Navigator.of(context).pop();
        notifyListeners();
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
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
        e.toString(),
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  // Update Pass

  Future<void> logout() async {
    _token = '';

    notifyListeners();
  }
}
