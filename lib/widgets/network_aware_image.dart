import 'package:flutter/material.dart';
import '../services/connectivity_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkAwareImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const NetworkAwareImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) =>
          placeholder ??
          const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
          ),
      errorWidget: (context, url, error) {
        return FutureBuilder<bool>(
          future: ConnectivityService.hasInternet(),
          builder: (context, snapshot) {
            final hasInternet = snapshot.data ?? true;

            if (!hasInternet) {
              // No internet connection
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off,
                        color: Colors.grey[600],
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'No connection',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Other error (not connectivity related)
            return errorWidget ??
                Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[600],
                    ),
                  ),
                );
          },
        );
      },
    );
  }
}
