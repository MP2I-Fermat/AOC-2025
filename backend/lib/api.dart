import 'dart:async';

import 'package:backend/handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_limiter/shelf_limiter.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';

final connectionHandler = ConnectionHandler();

final router = Pipeline()
    .addMiddleware(
      shelfLimiter(
        RateLimiterOptions(maxRequests: 20, windowSize: Duration(minutes: 1)),
      ),
    )
    .addHandler(
      (Router()..get(
            '/ws',
            webSocketHandler(
              (channel, _) => runZonedGuarded(
                () => connectionHandler.handle(channel),
                (e, s) {
                  channel.sink.close(4001);
                  print(e);
                  print(s);
                },
              ),
            ),
          ))
          .call,
    );
