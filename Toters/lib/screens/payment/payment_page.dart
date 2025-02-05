import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


import '../../models/order_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';

class PaymentPage extends StatefulWidget {
  final OrderModel orderModel;

  PaymentPage({required this.orderModel});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController _controller;
  late final String selectedUrl;
  bool _isLoading = true;
  bool _canRedirect = true;

  @override
  void initState() {
    super.initState();
    selectedUrl =
    '${AppConstants.BASE_URL}/payment-mobile?customer_id=${widget.orderModel.userId}&order_id=${widget.orderModel.id}';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("WebView is loading (progress: $progress%)");
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            setState(() {
              _isLoading = true;
            });
            _redirect(url);
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            setState(() {
              _isLoading = false;
            });
            _redirect(url);
          },
          onHttpError: (HttpResponseError error) {
            print('HTTP error: ${error}');
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            print('Navigating to: ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(selectedUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Payment"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              if (await _exitApp(context)) {
                Navigator.of(context).pop();
              }
            },
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _redirect(String url) {
    if (_canRedirect) {
      final isSuccess =
          url.contains('success') && url.contains(AppConstants.BASE_URL);
      final isFailed =
          url.contains('fail') && url.contains(AppConstants.BASE_URL);
      final isCancel =
          url.contains('cancel') && url.contains(AppConstants.BASE_URL);

      if (isSuccess || isFailed || isCancel) {
        _canRedirect = false;

        if (isSuccess) {
          // Navigate to success page
          print("Redirecting to success...");
          // Uncomment and add navigation logic if needed
          // Get.offNamed(RouteHelper.getOrderSuccessRoute(widget.orderModel.id.toString(), 'success'));
        } else if (isFailed || isCancel) {
          // Navigate to failure page
          print("Redirecting to failure...");
          // Uncomment and add navigation logic if needed
          // Get.offNamed(RouteHelper.getOrderSuccessRoute(widget.orderModel.id.toString(), 'fail'));
        }
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    } else {
      print("App exited");
      return true;
    }
  }
}
