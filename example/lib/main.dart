import 'dart:convert';
import 'dart:developer';
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
  ValueNotifier isLoadingNotifier = ValueNotifier(false);

  _onTestCheckout() async {
    isLoadingNotifier.value = true;
    // use your own merchant server
    // https://totalprocessing.docs.oppwa.com/tutorials/mobile-sdk/integration/server
    final response = await http
        .get(Uri.parse('https://velopos.kakzaki.my.id/api/checkouttrial'));

    if (response.statusCode == 200) {
      isLoadingNotifier.value = false;

      final responseBody = jsonDecode(response.body);
      final checkoutId = responseBody['id'];

      log("$responseBody", name: "responseBody");

      if (checkoutId != null) {
        _totalProcessingPlugin.startCheckout(
          checkoutId: checkoutId.toString(),
          settings: TotalProcessingCheckoutSettings(
              paymentBrands: ["VISA", "DIRECTDEBIT_SEPA"],
              shopperResultURL: "com.companyname.appname.payments://result"),
        );
      }
    } else {
      isLoadingNotifier.value = false;
      throw Exception('Failed to load checkout ID');
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
          child: ValueListenableBuilder(
            valueListenable: isLoadingNotifier,
            builder: (context, value, child) {
              return value == true
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _onTestCheckout,
                      child: const Text('TEST CHECKOUT'),
                    );
            },
          ),
        ),
      ),
    );
  }
}
