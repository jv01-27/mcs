import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

// Credenciales de Google API
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "mcs-integrated-hawk-438516-u9",
  "private_key_id": "771ae6c065b7f858bdb1d362478412533408cccd",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCwTIS1TErUOSCC\nuFND61ZNofcDKl+9afQgRJo4GGR43loJT5UhXEJ0gXb1vmkBnt6g4OZ9kEWHU0Dt\nZ3bbBw3Wnx89yY4Y24gvtT36bRKxpelShunVWShX+vcz3UFsKZIRCLjEsX5cjn7G\neuAnouu2Vf5oR59ZwNLTy4XF5NPqRBwMq/dR89xQRKhaifSrZesn7/wjCpwW8bVv\n+MfJ9tS5yZiA/K5uizMT3zBDKONvzvZPIjpSftdHYzIOrkxhfnbMWy4zcahx/fXp\nOPAYp5XYObpINQhY7xTs1kIMqzmhoUmlZkFspOdhfwNpLPu8IKRqEqSWkQW2Y6k9\nW7MlpdxlAgMBAAECgf8lJjN7Vd9SSrdkYnLwXO3g38A7aofCGvUPLPPEFybb34z8\n94D1P4ndyhTHJYMXcMY/510cGFjHOXy8GB9zeaV/FCUdmNst04Z7aqddnbq2QqNL\nXQYFbu7KRe1DDsABisD1nQuLEaLV+oYuE9LSwDrOsTO//nQVoEUFlQf+1fIKlaA+\nlQDTlTW9st0RKPKpJbGG4ORsrbAXUm0LrPX5t2ET/KX8zYglqpwkPKIhmlYoe6o5\nGd6KAtUh1jfVZusf3ahfkcI+FgvgAwkMQLFKOpt1TnZdB2QXVWz969O79p29r66+\n3rTJ52HGbSX69/wmcRwLstXly0UOlhVfgTNj0vMCgYEA6oUbvdkF0dm2zdvA7aDs\n8RrrhmSLvMwTXLCeXM6E8ROan3yJwhZWZZX9bGfE8iKJ2lQ7eDjg15c2dvwlp5iF\nRN8yE2+jt/RnCLLydNBLtFMw2K6bVqbqW4NgbEUIChhe168SLGROyPKxrwR0o7q0\n0IMIJPt90KvqoiWk4MXQ168CgYEAwHJGi+Z2LEE0Przk5zMmW00Bao0fKa3z4ni9\nyB+Dt0cdjU7DxUx0tAnQYNMmqnXvvJ3j8nkY8IIGKHe7H0EqNlP1mBkrvpUKkKcR\nI4zAjdjBi+Zc5yxWo01zAM6yIelfi5h8HxbXjNeWl0ZfZWosHHbY+CmerB/765pT\n3jYO/isCgYA92JqHR2tMexDFWxWW1SCHOOUxzOQ5Bsx4Xi91JBVVCil1s78UixV/\ntr1dUERU4pzeEeaY/s70q/D2EerQNt22WvH2xDM1uONPHPnpqmC8jk/MZMecY2pc\nddoA03eaSfEBCi9Nu6o3PiFzmUY1Q3CZqGSGdDgqxpua5TiE+kXoCwKBgGU9eOlu\nQyrC3qZGnzEV0o7jcuRH+2Xk0lGI7WYTViqb6esFza3Eq/xu0UWurz+rrYQPl/Re\nSoV0EaNGYZVupbNQ9fme/ElVhOpWSYjnKgE1T5S2ipc+1xEv1FlPY5y9dfstK9b7\nIEhCvkE0z0i90xjiWQAsfQHWDaSDWq2iyL5jAoGBAMRJB7ixg8y12NjbmsWcMZCH\n71dP4mC/eqqCfmKiJSq6rEOZiohp4bi60GnivkqVfoyQ69x5TmF5hrDF4I9xFq80\nlVlV7jYx6zTESicm9LnATpQlEuHXs7C36cn2gPp4WIlLWmqwt+/VvpH/aFWIv90G\ndnD5icJnIoshtltrxsTv\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@mcs-integrated-hawk-438516-u9.iam.gserviceaccount.com",
  "client_id": "117738842098700796160",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40mcs-integrated-hawk-438516-u9.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

// ID de la hoja de cálculo de Google Sheets
const _spreadsheetId = '1w26jdBCXNc-tZiCJcYzzG0p4j7tvYLRNZe87cdFk9bg';

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
  int _productsPerBox = 0;
  int _totalProductsSubmitted = 0;

  final TextEditingController _dateController = TextEditingController();

  // Enviar los datos a Google Sheets
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (kDebugMode) {
        print('Fecha: $_fecha');
        print('SKU: $_sku');
        print('Código: $_codigo');
        print('Modelo: $_modelo');
        print('Marca: $_marca');
      }

      // Cálculo del número de caja
      int currentBoxNumber = (_productsPerBox > 0)
          ? ((_totalProductsSubmitted ~/ _productsPerBox) + 1)
          : 0; // Calcula el número de caja

      // Incrementa el conteo total de productos enviados
      _totalProductsSubmitted++;

      // Conexión con Google Sheets
      final gsheets = GSheets(_credentials);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      var sheet = ss.worksheetByTitle('Productos');
      sheet ??= await ss.addWorksheet('Productos');

      // Insertar encabezados si es la primera vez
      final headers = ['Fecha', 'SKU', 'Codigo', 'Modelo', 'Marca', 'N° de Caja'];
      await sheet.values.insertRow(1, headers);

      // Insertar los datos del producto
      final data = [_fecha, _sku, _codigo, _modelo, _marca, currentBoxNumber];
      await sheet.values.appendRow(data);

      if (kDebugMode) {
        print('Datos guardados en Google Sheets');
      }

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Datos enviados a Google Sheets'),
        ),
      );
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
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'N° de Productos por caja'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa el número de productos por caja.';
                  }
                  return null;
                },
                onSaved: (value) {
                  // Store the entered value in a new variable, e.g., _productsPerBox
                  _productsPerBox =
                      int.tryParse(value!) ?? 0; // Handle empty input
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
