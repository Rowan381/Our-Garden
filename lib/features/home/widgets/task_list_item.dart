import 'package:flutter/material.dart';
import '../../../data/models/task_model.dart';
import '../../../app/theme/app_theme.dart';

class TaskListItem extends StatelessWidget {
  final TaskModel task;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback? onTap;

  const TaskListItem({
    super.key,
    required this.task,
    this.isSelected = false,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(
          color: isSelected 
              ? AppTheme.primaryColor 
              : AppTheme.primaryColor.withValues(alpha: 0.2),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: isSelected,
          onChanged: onChanged,
          activeColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        title: Text(
          task.title,
          style: AppTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: task.isCompleted 
                ? AppTheme.secondaryTextColor 
                : AppTheme.primaryTextColor,
            decoration: task.isCompleted 
                ? TextDecoration.lineThrough 
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                task.description,
                style: AppTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.secondaryTextColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  _getTaskIcon(),
                  size: 12,
                  color: _getTaskColor(),
                ),
                const SizedBox(width: 4),
                Text(
                  task.category,
                  style: AppTheme.textTheme.bodySmall?.copyWith(
                    color: _getTaskColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDueDate(task.dueDate),
                  style: AppTheme.textTheme.bodySmall?.copyWith(
                    color: task.isOverdue 
                        ? AppTheme.errorColor 
                        : AppTheme.secondaryTextColor,
                    fontWeight: task.isOverdue ? FontWeight.w500 : null,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: onTap,
        trailing: task.isOverdue && !task.isCompleted
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Overdue',
                  style: AppTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.errorColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  IconData _getTaskIcon() {
    switch (task.category.toLowerCase()) {
      case 'watering':
        return Icons.water_drop;
      case 'fertilizing':
        return Icons.eco;
      case 'pruning':
        return Icons.content_cut;
      case 'harvesting':
        return Icons.agriculture;
      case 'planting':
        return Icons.local_florist;
      case 'weeding':
        return Icons.delete_outline;
      default:
        return Icons.task;
    }
  }

  Color _getTaskColor() {
    switch (task.priority.toLowerCase()) {
      case 'high':
        return AppTheme.errorColor;
      case 'medium':
        return AppTheme.warningColor;
      case 'low':
        return AppTheme.successColor;
      default:
        return AppTheme.secondaryTextColor;
    }
  }

  String _formatDueDate(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(dueDate.year, dueDate.month, dueDate.day);
    
    if (dueDay == today) {
      return 'Today';
    } else if (dueDay == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else if (dueDay == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      final difference = dueDay.difference(today).inDays;
      if (difference > 0) {
        return 'In $difference days';
      } else {
        return '${difference.abs()} days ago';
      }
    }
  }
} 