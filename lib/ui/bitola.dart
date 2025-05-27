import 'package:flutter/material.dart';

class BitolaScreen extends StatefulWidget {
  const BitolaScreen({super.key});

  @override
  State<BitolaScreen> createState() => _BitolaScreenState();
}

class _BitolaScreenState extends State<BitolaScreen> {
  String distancia = '';
  String corrente = '';

  double bitola110 = 0.0;
  double bitola220 = 0.0;

  void calcularBitola() {
    double d = double.tryParse(distancia) ?? 0;
    double c = double.tryParse(corrente) ?? 0;

    if (d <= 0 || c <= 0) return;

    bitola110 = (2 * c * d) / 294.64;
    bitola220 = (2 * c * d) / 510.4;

    setState(() {});

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Resultado"),
        content: Text(
          "A bitola recomendada para Tensão 127V é: ${bitola110.toStringAsFixed(2)} mm²\n"
          "A bitola recomendada para Tensão 220V é: ${bitola220.toStringAsFixed(2)} mm²",
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Fechar"))],
      ),
    );
  }

  Widget campoTexto(String label, String hint, Function(String) onChanged) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
        TextField(
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: hint),
          keyboardType: TextInputType.number,
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cálculo de Bitola de Fio')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            campoTexto('Distância em metros:', 'Digite a distância', (v) => distancia = v),
            SizedBox(height: 12),
            campoTexto('Corrente:', 'Digite a corrente em amperes', (v) => corrente = v),
            SizedBox(height: 20),
            ElevatedButton(onPressed: calcularBitola, child: Text('Calcular')),
            SizedBox(height: 20),
            Text('A bitola recomendada para Tensão 127V é: ${bitola110.toStringAsFixed(2)}'),
            Text('A bitola recomendada para Tensão 220V é: ${bitola220.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
