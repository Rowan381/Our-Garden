import 'package:flutter/material.dart';
import '../../../data/models/garden_model.dart';
import '../../../app/theme/app_theme.dart';

class GardenCard extends StatelessWidget {
  final GardenModel garden;
  final VoidCallback? onTap;
  final bool showLastWatered;

  const GardenCard({
    super.key,
    required this.garden,
    this.onTap,
    this.showLastWatered = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          border: Border.all(
            color: AppTheme.primaryColor.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Garden Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusM),
                topRight: Radius.circular(AppTheme.radiusM),
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: garden.imageUrl != null
                    ? Image.network(
                        garden.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderImage();
                        },
                      )
                    : _buildPlaceholderImage(),
              ),
            ),
            
            // Garden Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Garden Name
                  Text(
                    garden.name,
                    style: AppTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Garden Type
                  Text(
                    garden.type,
                    style: AppTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.secondaryTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  if (showLastWatered && garden.lastWatered != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.water_drop,
                          size: 12,
                          color: AppTheme.secondaryTextColor,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _formatLastWatered(garden.lastWatered!),
                            style: AppTheme.textTheme.bodySmall?.copyWith(
                              color: AppTheme.secondaryTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
      child: Icon(
        Icons.eco,
        color: AppTheme.primaryColor,
        size: 30,
      ),
    );
  }

  String _formatLastWatered(DateTime lastWatered) {
    final now = DateTime.now();
    final difference = now.difference(lastWatered);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
} 