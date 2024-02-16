import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/scheduler.dart';
import 'package:total_processing/total_processing.dart';
import 'package:flutter/services.dart';

class CustomUIPage extends StatefulWidget {
  final String checkoutId;
  const CustomUIPage({Key? key, required this.checkoutId}) : super(key: key);

  @override
  State<CustomUIPage> createState() => _CustomUIPageState();
}

class _CustomUIPageState extends State<CustomUIPage> {
  final _totalProcessingPlugin = TotalProcessingPlugin();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  String cardBrand = 'VISA';
  String shopperResultUrl = "com.companyname.appname.payments://result";

  _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _onTestCheckout() async {
    FocusScope.of(context).unfocus();
    if (expiryController.text.isEmpty) {
      _showSnackbar('Please enter expiry date');
      return;
    }
    final expiryParts = expiryController.text.split('/');
    if (expiryParts.length != 2) {
      _showSnackbar('Please enter a valid expiry date (MM/YY)');
      return;
    }
    final expiryMonth = expiryParts[0];
    final expiryYear = expiryParts[1];
    try {
      _totalProcessingPlugin.customUIPay(
          checkoutID: widget.checkoutId,
          cardHolder: cardHolderController.text,
          cardNumber: cardNumberController.text.replaceAll(' ', ''),
          // Remove spaces from card number
          expiryMonth: expiryMonth,
          expiryYear: expiryYear,
          cvc: cvcController.text,
          cardBrand: cardBrand,
          shopperResultUrl: shopperResultUrl);
    } catch (e) {
      _showSnackbar('$e');
    }
  }

  StreamSubscription? _customUIResultStream;

  @override
  void initState() {
    SchedulerBinding.instance.endOfFrame.then((_) async {
      _customUIResultStream =
          _totalProcessingPlugin.customUIResultStream.listen((event) async {
        log("$event", name: "customUIResultStream");

        if (event != null) {
          if (event['isErrored'] == true) {
            return _showSnackbar('${event['paymentError']['errorMessage']}');
          }

          if (event['transaction'] != null) {
            _showSnackbar('Payment is Successful');
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  _CardNumberInputFormatter(),
                ],
              ),
              TextFormField(
                controller: cardHolderController,
                decoration: const InputDecoration(
                  labelText: 'Card Holder Name',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: expiryController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  _ExpiryDateInputFormatter(),
                ],
              ),
              TextFormField(
                controller: cvcController,
                decoration: const InputDecoration(
                  labelText: 'CVC',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3), // Limit to 3 characters
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _onTestCheckout,
                  child: const Text('Pay'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (text.length > 19) {
      return oldValue;
    }

    if (oldValue.text.length < newValue.text.length) {
      if (text.length == 4 || text.length == 9 || text.length == 14) {
        text += ' '; // Add a space after every four characters
      }
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (text.length > 5) {
      return oldValue;
    }

    if (oldValue.text.length < newValue.text.length) {
      if (text.length == 2) {
        text += '/';
      }
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
