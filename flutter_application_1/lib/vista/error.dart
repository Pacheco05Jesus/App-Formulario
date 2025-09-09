import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const ErrorView({required this.errorMessage, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
          SizedBox(height: 16),
          Text(
            errorMessage,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent[400],
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
