import 'dart:io';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'package:backend/api.dart' as api;
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) async {
  final parser = ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '80')
    ..addOption('addr', defaultsTo: '0.0.0.0');

  final parsedArgs = parser.parse(args);

  final router = Router()..mount('/api', api.router.call);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await serve(
    handler,
    InternetAddress.tryParse(parsedArgs.option('addr')!)!,
    int.parse(parsedArgs.option('port')!),
  );

  print('Server listening on port ${server.port}');
}
