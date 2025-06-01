import 'package:flutter/material.dart';
import '../routing/routes.dart';
import '../../ui/views/chat_view.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.chatRoute:
        return MaterialPageRoute(builder: (context) => CharView());

      default:
        return MaterialPageRoute(
            builder: (BuildContext conktext) => const Scaffold(
                  body: Text('This Page does not Exist'),
                ));
    }
  }
}
