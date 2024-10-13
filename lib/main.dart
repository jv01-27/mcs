import 'package:gsheets/gsheets.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
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

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
const _spreadsheetId = '';

void main() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('example');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('example');

  // update cell at 'B2' by inserting string 'new'
  await sheet.values.insertValue('new', column: 2, row: 2);
  // prints 'new'
  print(await sheet.values.value(column: 2, row: 2));
  // get cell at 'B2' as Cell object
  final cell = await sheet.cells.cell(column: 2, row: 2);
  // prints 'new'
  print(cell.value);
  // update cell at 'B2' by inserting 'new2'
  await cell.post('new2');
  // prints 'new2'
  print(cell.value);
  // also prints 'new2'
  print(await sheet.values.value(column: 2, row: 2));

  // insert list in row #1
  final firstRow = ['index', 'letter', 'number', 'label'];
  await sheet.values.insertRow(1, firstRow);
  // prints [index, letter, number, label]
  print(await sheet.values.row(1));

  // insert list in column 'A', starting from row #2
  final firstColumn = ['0', '1', '2', '3', '4'];
  await sheet.values.insertColumn(1, firstColumn, fromRow: 2);
  // prints [0, 1, 2, 3, 4, 5]
  print(await sheet.values.column(1, fromRow: 2));

  // insert list into column named 'letter'
  final secondColumn = ['a', 'b', 'c', 'd', 'e'];
  await sheet.values.insertColumnByKey('letter', secondColumn);
  // prints [a, b, c, d, e, f]
  print(await sheet.values.columnByKey('letter'));

  // insert map values into column 'C' mapping their keys to column 'A'
  // order of map entries does not matter
  final thirdColumn = {
    '0': '1',
    '1': '2',
    '2': '3',
    '3': '4',
    '4': '5',
  };
  await sheet.values.map.insertColumn(3, thirdColumn, mapTo: 1);
  // prints {index: number, 0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6}
  print(await sheet.values.map.column(3));

  // insert map values into column named 'label' mapping their keys to column
  // named 'letter'
  // order of map entries does not matter
  final fourthColumn = {
    'a': 'a1',
    'b': 'b2',
    'c': 'c3',
    'd': 'd4',
    'e': 'e5',
  };
  await sheet.values.map.insertColumnByKey(
    'label',
    fourthColumn,
    mapTo: 'letter',
  );
  // prints {a: a1, b: b2, c: c3, d: d4, e: e5, f: f6}
  print(await sheet.values.map.columnByKey('label', mapTo: 'letter'));

  // appends map values as new row at the end mapping their keys to row #1
  // order of map entries does not matter
  final secondRow = {
    'index': '5',
    'letter': 'f',
    'number': '6',
    'label': 'f6',
  };
  await sheet.values.map.appendRow(secondRow);
  // prints {index: 5, letter: f, number: 6, label: f6}
  print(await sheet.values.map.lastRow());

  // get first row as List of Cell objects
  final cellsRow = await sheet.cells.row(1);
  // update each cell's value by adding char '_' at the beginning
  cellsRow.forEach((cell) => cell.value = '_${cell.value}');
  // actually updating sheets cells
  await sheet.cells.insert(cellsRow);
  // prints [_index, _letter, _number, _label]
  print(await sheet.values.row(1));
}