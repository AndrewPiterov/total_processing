import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/scheduler.dart';
import 'package:total_processing/total_processing.dart';

class CustomUIPage extends StatefulWidget {
  final String checkoutId;
  const CustomUIPage({super.key, required this.checkoutId});

  @override
  State<CustomUIPage> createState() => _CustomUIPageState();
}

class _CustomUIPageState extends State<CustomUIPage> {
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
    // _totalProcessingPlugin.customUIPay(
    //       checkoutID: widget.checkoutID,
    //       cardHolder: cardHolder,
    //       cardNumber: cardNumber,
    //       expiryMonth: expiryMonth,
    //       expiryYear: expiryYear,
    //       cvc: cvc,
    //       cardBrand: cardBrand,
    //       shopperResultUrl: shopperResultUrl);
  }

  StreamSubscription? _customUIResultStream;

  @override
  void initState() {
    SchedulerBinding.instance.endOfFrame.then((value) async {
      _customUIResultStream =
          _totalProcessingPlugin.customUIResultStream.listen((event) async {
        log("$event", name: "customUIResultStream");
        isLoadingNotifier.value = false;
        if (event != null) {
          if (event['isErrored'] == true) {
            return _showSnacbar('${event['paymentError']['errorMessage']}');
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
    _customUIResultStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom UI Payment'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: isLoadingNotifier,
              builder: (context, value, child) {
                return value == true
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _onTestCheckout,
                        child: const Text('Pay'),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
