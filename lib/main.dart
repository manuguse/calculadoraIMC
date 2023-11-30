import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const IMCScreen()),
  );
}

class IMCScreen extends StatefulWidget {
  const IMCScreen({super.key});

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  final alturaController = TextEditingController(),
      pesoController = TextEditingController();
  double? imc;
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
        ),
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || double.tryParse(value.replaceAll(',', '.')) == null) {
                      return 'Valor inválido';
                    }
                    return null;
                  },
                  controller: alturaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    label: Text(
                      'Altura (cm)',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || double.tryParse(value.replaceAll(',', '.')) == null) {
                      return 'Valor inválido';
                    }
                    return null;
                  },
                  controller: pesoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    label: Text('Peso (kg)'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (key.currentState?.validate() ?? false) {
                      final alturaText = alturaController.text;
                      final pesoText = pesoController.text;
                      final altura = double.parse(alturaText.replaceAll(',', '.')) / 100;
                      final peso = double.parse(pesoText.replaceAll(',', '.'));

                      setState(() {
                        imc = peso / (altura * altura);
                      });
                    }
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ))),
                  child: const Text('Calcular'),
                ),
                if (imc != null)
                  Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'IMC: ${imc!.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Classificação: ${analisa_imc(imc!)}',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String analisa_imc(double imc) {
  if (imc < 18.5) {
    return ("magreza");
  } else if (imc < 25) {
    return ("normal");
  } else if (imc < 30) {
    return ("sobrepeso");
  } else if (imc < 40) {
    return ("obesidade");
  } else {
    return ("obesidade grave");
  }
}
