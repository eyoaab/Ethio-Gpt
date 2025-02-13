import 'dart:async';
import 'dart:developer';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionTracker extends StatefulWidget {
  final Widget child;
  const ConnectionTracker({super.key, required this.child});

  @override
  _ConnectionTrackerState createState() => _ConnectionTrackerState();
}

class _ConnectionTrackerState extends State<ConnectionTracker> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _subscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    log('the update part for connection');
    // Determine if any of the results indicate a connection
    bool isNowConnected =
        results.any((result) => result != ConnectivityResult.none);

    if (isNowConnected != _isConnected) {
      setState(() => _isConnected = isNowConnected);
      _showSnackBar(isNowConnected);
    }
  }

  void _showSnackBar(bool isConnected) {
    log('isconneted');
    log(isConnected.toString());
    showCustomSnackBar(
      context,
      isConnected ? 'Internet is back!' : 'You are offline!',
      isConnected,
    );
  }

  @override
  void dispose() {
    log('disspose is called');
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
