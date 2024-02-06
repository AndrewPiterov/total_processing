import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:total_processing/total_processing.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Total Processing',
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _totalProcessingPlugin = TotalProcessingPlugin();
  ValueNotifier isLoadingNotifier = ValueNotifier(false);

  _showSnacbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _onTestCheckout() async {
    isLoadingNotifier.value = true;
    // TODO: use your own merchant server
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
              shopperResultURL:
                  "com.companyname.appname.payments://result"), // android version no longer use it
        );
      }
    } else {
      isLoadingNotifier.value = false;
      _showSnacbar('Failed to load checkout ID');
    }
  }

  StreamSubscription? _checkoutResultStream;

  @override
  void initState() {
    SchedulerBinding.instance.endOfFrame.then((value) async {
      _checkoutResultStream = _totalProcessingPlugin.handleCheckoutResultStream
          .listen((event) async {
        log("$event", name: "handleCheckoutResultStream");

        if (event != null) {
          if (event['isErrored'] == true) {
            return _showSnacbar('${event['paymentError']['errorMessage']}');
          }

          if (event['isCanceled'] == true) {
            return _showSnacbar('Payment is canceled');
          }

          if (event['transaction'] != null) {
            _showSnacbar('Payment is Successful');
            log("${event['transaction']}", name: "transaction");
          }

          // TODO: use your own merchant server to get status of the transaction
          // https://totalprocessing.docs.oppwa.com/tutorials/mobile-sdk/integration/server
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _checkoutResultStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
