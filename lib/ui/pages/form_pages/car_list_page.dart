import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:front/ui/ui.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({super.key});

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 60, 15, 15),
          child: Column(
            children: [
              DottedBorder(
                color: Colors.grey[400]!,
                strokeWidth: 1,
                child: TextButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll<Size?>(Size(
                      (MediaQuery.of(context).size.width * 0.8),
                      80,
                    )),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.FORMCAR);
                  },
                  child: Text(
                    'Adicionar Carro',
                    style: TextStyle(
                      color: Colors.grey[600]!,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
