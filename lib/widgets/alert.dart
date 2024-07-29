import 'package:flutter/material.dart';

class SimpleAlertDialog extends StatelessWidget {
  final String message;

  const SimpleAlertDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(message, textAlign: TextAlign.center),
          ),
          SizedBox(height: 16.0), 
          TextButton(
            child: Text('Dismiss'),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
        ],
      ),
    );
  }
}
