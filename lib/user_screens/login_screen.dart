import 'dart:math';

import 'package:flutter/material.dart';

import '../content_models/index.dart';
import '../utils/constants.dart';
import 'index.dart';

class LoginDialog extends StatefulWidget {
  final Broker broker;

  const LoginDialog({super.key, required this.broker});

  @override
  LoginDialogState createState() => LoginDialogState();
}

class LoginDialogState extends State<LoginDialog> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: widget.broker.color,
            child: Text(
              widget.broker.logo,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 12),
          Expanded(child: Text('$login${widget.broker.name}'))
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: username,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: password,
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(cancel),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleLogin,
          child: _isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(login),
        ),
      ],
    );
  }

  void _handleLogin() async {
    if (_usernameController.text.trim().isEmpty &&
        _passwordController.text.trim().isEmpty) {
      _showErrorDialog(enterPasswordAndUserName);
      return;
    }

    if (_usernameController.text.trim().isEmpty) {
      _showErrorDialog(enterUserName);
      return;
    }

    if (_passwordController.text.trim().isEmpty) {
      _showErrorDialog(enterPassword);
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Mock response logic
    final random = Random();
    int responseCode;
    if (widget.broker.name.toUpperCase() == 'ZERODHA') {
      responseCode = 200;
    } else {
      responseCode = [200, 400, 500][random.nextInt(3)];
    }

    setState(() => _isLoading = false);

    switch (responseCode) {
      case 200:
        if (mounted) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
        break;
      case 400:
        _showErrorDialog(invalidCredentials);
        break;
      case 500:
        _showErrorDialog(serverError);
        break;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loginFailed),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(oK),
          ),
        ],
      ),
    );
  }
}
