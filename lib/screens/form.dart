import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _fecha = '';
  String _sku = '';
  String _codigo = '';
  String _modelo = '';
  String _marca = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); 
      if (kDebugMode) {
        print('Fecha: $_fecha');
        print('SKU: $_sku');
        print('Código: $_codigo');
        print('Modelo: $_modelo');
        print('Marca: $_marca');
      }
    }
  }

    final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Producto'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Fecha'),
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _DateFormattingFormatter(),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa la fecha.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fecha = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'SKU'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa el SKU.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _sku = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Código'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa el código.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _codigo = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa el modelo.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _modelo = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa la marca.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _marca = value!;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateFormattingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isNotEmpty) {
      final newText = _formatDate(newValue.text);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),

      );
    }
    return newValue;

  }

  String _formatDate(String date) {
    if (date.length <= 2) {
      return date;
    } else if (date.length <= 4) {
      return '${date.substring(0, 2)}/${date.substring(2)}';
    } else if (date.length <= 8) {
      return '${date.substring(0, 2)}/${date.substring(2, 4)}/${date.substring(4)}';
    }
    return date;
  }
}
