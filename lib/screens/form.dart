import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
                decoration: const InputDecoration(labelText: 'Fecha'),
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
