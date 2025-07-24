import 'package:flutter/material.dart';
import '../services/connectivity_service.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: ConnectivityService.connectivityStream,
      builder: (context, snapshot) {
        // If we have no data yet or we're connected, don't show the banner
        final bool isConnected = snapshot.data ?? true;
        if (isConnected) {
          return const SizedBox.shrink();
        }

        // Show the offline banner
        return Container(
          width: double.infinity,
          color: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'You are offline',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
