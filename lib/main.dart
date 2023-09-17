import 'dart:convert';
import 'dart:html' as html;

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:stripe_checkout/stripe_checkout.dart';
import 'package:web_stripe/errorpage.dart';
import 'package:web_stripe/successpage.dart';




String urlss = "";
List userdata=["my","code","working"];
void main() {
  urlss = html.window.location.href;
  print('Current Host: $urlss');
  // final router = FluroRouter();
  // Routes.router = router;
  // Routes.configureRoutes();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Deep Linking Example',
      navigatorKey: _navigatorKey,
      // onGenerateRoute: Routes.router!.generator,
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        Widget routeWidget =  const MyHomePage(title: "home");
        final routePath = settings.name ?? '/';
        print('Route Path: $routePath'); // Debug statement
        final pathSegments = routePath.split('/');
        print('Path Segments: $pathSegments'); // Debug statement


          if (pathSegments[1] == 'success') {

            routeWidget = SuccessWidget();

          } else if (pathSegments[1] == 'error') {


            routeWidget = Error_Widget();
          }


        return MaterialPageRoute(
          builder: (context) => routeWidget,
          settings: settings,
          fullscreenDialog: true,
        );
      },
      // home: MyHomePage(title: "home"),
      // initialRoute: '/',
    );
  }

  void initDeepLinks() {
    final uri = Uri.parse(html.window.location.href);
    print(uri.fragment);

    // Check the path and perform actions accordingly
    if (uri.fragment != null && uri.fragment.isNotEmpty) {
      final route = uri.fragment;
      final navigatorContext = _navigatorKey.currentContext;
      if (navigatorContext != null) {
        _navigatorKey.currentState?.pushNamed(route);
      //  Routes.router!.navigateTo(navigatorContext, route, replace: true);
      }
    }
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String publishableKey =
      'Public_Key';

  _incrementCounter() async {
    final sessionId = await createCheckoutSession();
    if (sessionId != null) {
      print('Checkout session ID: ${sessionId['url']}');
      print('Checkout session ID: ${sessionId['id']}');
      await redirectToCheckout(
        context: context,
        sessionId: sessionId['id'],
        publishableKey: publishableKey,
      );
    } else {
      print('Checkout session creation failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<Map?> createCheckoutSession() async {
  final url = Uri.parse('https://api.stripe.com/v1/checkout/sessions');
  const secret = 'Secret_Key';
  Map<String, String> headers = {
    'Authorization': 'Bearer ' + secret,
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  final body = {
    'success_url': '${urlss}#/success',
    'cancel_url': "${urlss}#/error",
    'payment_method_types[0]': 'card',
    'line_items[0][price]': 'price_XXXXXXXX', // Replace with your actual Price ID
    'line_items[0][quantity]': '1',
    'mode': 'payment',
  };

  var response = await http.post(
    url,
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final sessionId = responseData['id'];
    print(responseData);
    return responseData;
  } else {
    print('Failed to create checkout session: ${response.statusCode}');
    print(response.body);
    return null;
  }
}
