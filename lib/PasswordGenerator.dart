import 'dart:math';
import 'package:flutter/material.dart';

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String _password = '';
  int _length = 8;
  bool _useUppercase = false;
  bool _useSpecialChars = false;
  bool _useNumbers = false;

  void _generatePassword() {
    setState(() {
      _password = _getRandomPassword(
          _length, _useUppercase, _useSpecialChars, _useNumbers);
    });
  }

  String _getRandomPassword(
      int length, bool useUppercase, bool useSpecialChars, bool useNumbers) {
    final random = Random.secure();
    const lettersLower = "abcdefghijklmnopqrstuvwxyz";
    const lettersUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const specialChars = "!@#\$%^&*()_-+=[{]}|;:,<.>/?";
    const numbers = "0123456789";

    String chars = lettersLower;
    String password = "";

    if (useUppercase) {
      chars += lettersUpper;
    }

    if (useSpecialChars) {
      chars += specialChars;
    }

    if (useNumbers) {
      chars += numbers;
    }

    for (int i = 0; i < length; i++) {
      int randIndex = random.nextInt(chars.length);
      password += chars[randIndex];
    }

    return password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generador"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text("Largo contraseña"),
              Slider(
                min: 8,
                max: 30,
                divisions: 22,
                activeColor: Colors.purple,
                inactiveColor: Colors.purple.shade100,
                thumbColor: Colors.purple,
                value: _length.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _length = value.round();
                  });
                },
                label: _length.toString(),
              ),
              CheckboxListTile(
                title: const Text("Mayusculas"),
                value: _useUppercase,
                onChanged: (value) {
                  setState(() {
                    _useUppercase = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Caracteres especiales"),
                value: _useSpecialChars,
                onChanged: (value) {
                  setState(() {
                    _useSpecialChars = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Numeros"),
                value: _useNumbers,
                onChanged: (value) {
                  setState(() {
                    _useNumbers = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _generatePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Background color
                ),
                child: const Text("Generar"),
              ),
              const SizedBox(height: 16.0),
              Container(
                decoration: const BoxDecoration(color: Color.fromARGB(255, 235, 157, 228)),
                alignment: Alignment.center,
                child: SelectableText(
                  _password,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
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
