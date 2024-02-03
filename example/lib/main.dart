import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:total_processing/total_processing.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _totalProcessingPlugin = TotalProcessingPlugin();

  _onTestCheckout() async {
    // use your own merchant server
    // https://totalprocessing.docs.oppwa.com/tutorials/mobile-sdk/integration/server
    final response = await http
        .get(Uri.parse('https://velopos.kakzaki.my.id/api/checkouttrial'));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final checkoutId = responseBody['id'];

      if (checkoutId != null) {
        _totalProcessingPlugin.checkoutSettings(
            paymentBrands: ["VISA", "DIRECTDEBIT_SEPA"],
            shopperResultURL: "com.companyname.appname.payments://result");
        _totalProcessingPlugin.startCheckout(checkoutId: checkoutId);
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _onTestCheckout,
            child: const Text('TEST CHECKOUT'),
          ),
        ),
      ),
    );
  }
}
