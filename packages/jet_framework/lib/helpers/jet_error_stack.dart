import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jet_framework/helpers/jet_logger.dart';

class JetErrorStack {
  JetErrorStack._();

  static init() {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return JetStackErrorWidget(errorDetails: errorDetails);
    };

    FlutterError.onError = (FlutterErrorDetails details) {
      String stack = details.stack.toString();
      RegExp regExp = RegExp(r'\(package:[A-z/.:0-9]+\)');
      RegExp webRegExp = RegExp(r'packages/[A-z_]+(/[A-z/.:0-9]+\s[0-9:]+)');

      String? className = regExp.firstMatch(stack)?.group(0) ??
          webRegExp.firstMatch(stack)?.group(0) ??
          '';

      if (kDebugMode) {
        String exceptionAsString = details.exceptionAsString();
        if (exceptionAsString.isNotEmpty) {
          dump(exceptionAsString, tag: 'Error Details');
        }

        if (className.isNotEmpty) {
          print('File: $className');
        }
      }
    };
  }
}

class JetStackErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const JetStackErrorWidget({required this.errorDetails, super.key});

  /// Extracts the class name from the stack trace.
  String _extractClassName() {
    final stack = errorDetails.stack.toString();
    final regExp = RegExp(r'\(package:([A-z/.:0-9]+)\)');
    final match = regExp.firstMatch(stack);

    if (match == null) {
      return "File not found";
    }

    return match.group(1)!.replaceAll(RegExp(r'^.*/'), '');
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = errorDetails.exceptionAsString();
    final className = _extractClassName();
    final osVersion = Platform.operatingSystemVersion;
    final osName = Platform.operatingSystem;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red, Colors.black],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black.withAlpha(9),
                        radius: 60.0,
                        child: const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 60.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Oops, something went wrong!',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildErrorBox(errorMessage),
                      const SizedBox(height: 16.0),
                      _buildInfoBox('File: $className'),
                      const SizedBox(height: 10.0),
                      _buildInfoText('Operating System Version', osVersion),
                      const SizedBox(height: 10.0),
                      _buildInfoText('Operating System', osName),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a styled box for displaying error messages.
  Widget _buildErrorBox(String text) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a styled box for displaying informational text.
  Widget _buildInfoBox(String text) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a styled text widget for displaying informational text.
  Widget _buildInfoText(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
