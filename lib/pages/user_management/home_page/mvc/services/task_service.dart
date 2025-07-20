import '/backend/backend.dart';
import '/auth/firebase_auth/auth_util.dart';

/// Service class for handling task-related operations
class TaskService {
  /// Get all garden tasks for the current user
  static Future<List<GardenTasksRecord>> getUserGardenTasks() async {
    try {
      final query = await queryGardenTasksRecordOnce(
        queryBuilder: (gardenTasksRecord) => gardenTasksRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
      );
      return query;
    } catch (e) {
      print('Error fetching garden tasks: $e');
      return [];
    }
  }

  /// Get all plant tasks for the current user
  static Future<List<PlantTasksRecord>> getUserPlantTasks() async {
    try {
      final query = await queryPlantTasksRecordOnce(
        queryBuilder: (plantTasksRecord) => plantTasksRecord.where(
          'userCreatorID',
          isEqualTo: currentUserUid,
        ),
      );
      return query;
    } catch (e) {
      print('Error fetching plant tasks: $e');
      return [];
    }
  }

  /// Update garden task completion status
  static Future<bool> updateGardenTaskCompletion(
      GardenTasksRecord task, bool isCompleted) async {
    try {
      await task.reference.update(createGardenTasksRecordData(
        completedToday: isCompleted,
      ));
      return true;
    } catch (e) {
      print('Error updating garden task: $e');
      return false;
    }
  }

  /// Update plant task completion status
  static Future<bool> updatePlantTaskCompletion(
      PlantTasksRecord task, bool isCompleted) async {
    try {
      await task.reference.update(createPlantTasksRecordData(
        completedToday: isCompleted,
      ));
      return true;
    } catch (e) {
      print('Error updating plant task: $e');
      return false;
    }
  }

  /// Get today's tasks filtered by date
  static List<GardenTasksRecord> getTodaysGardenTasks(
      List<GardenTasksRecord> allTasks) {
    final today = DateTime.now();
    return allTasks.where((task) {
      // Add your date filtering logic here using today
      // For now, return all tasks
      // TODO: Implement actual date filtering when task has date field
      return true;
    }).toList();
  }

  /// Get today's plant tasks filtered by date
  static List<PlantTasksRecord> getTodaysPlantTasks(
      List<PlantTasksRecord> allTasks) {
    final today = DateTime.now();
    return allTasks.where((task) {
      // Add your date filtering logic here using today
      // For now, return all tasks
      // TODO: Implement actual date filtering when task has date field
      return true;
    }).toList();
  }

  /// Mark all overdue tasks as incomplete
  static Future<void> updateOverdueTasks() async {
    try {
      // Get all user tasks
      final gardenTasks = await getUserGardenTasks();
      final plantTasks = await getUserPlantTasks();

      // Update garden tasks
      for (final task in gardenTasks) {
        if (task.completedToday == true) {
          await updateGardenTaskCompletion(task, false);
        }
      }

      // Update plant tasks
      for (final task in plantTasks) {
        if (task.completedToday == true) {
          await updatePlantTaskCompletion(task, false);
        }
      }
    } catch (e) {
      print('Error updating overdue tasks: $e');
    }
  }
}
