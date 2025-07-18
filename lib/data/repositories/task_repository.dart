import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';
import '../../core/services/auth_service.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // Get garden tasks for current user
  Future<List<TaskModel>> getUserGardenTasks() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return [];

      final snapshot = await _firestore.collection('gardenTasks')
          .where('userId', isEqualTo: currentUser.uid)
          .orderBy('dueDate', descending: false)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return TaskModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error getting user garden tasks: $e');
      return [];
    }
  }

  // Get plant tasks for current user
  Future<List<TaskModel>> getUserPlantTasks() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return [];

      final snapshot = await _firestore.collection('plantTasks')
          .where('userId', isEqualTo: currentUser.uid)
          .orderBy('dueDate', descending: false)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return TaskModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error getting user plant tasks: $e');
      return [];
    }
  }

  // Get tasks by garden ID
  Future<List<TaskModel>> getTasksByGarden(String gardenId) async {
    try {
      final snapshot = await _firestore.collection('gardenTasks')
          .where('gardenId', isEqualTo: gardenId)
          .orderBy('dueDate', descending: false)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return TaskModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error getting tasks by garden: $e');
      return [];
    }
  }

  // Get tasks by plant ID
  Future<List<TaskModel>> getTasksByPlant(String plantId) async {
    try {
      final snapshot = await _firestore.collection('plantTasks')
          .where('plantId', isEqualTo: plantId)
          .orderBy('dueDate', descending: false)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return TaskModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error getting tasks by plant: $e');
      return [];
    }
  }

  // Create a new garden task
  Future<String?> createGardenTask(TaskModel task) async {
    try {
      final docRef = await _firestore.collection('gardenTasks').add(task.toJson());
      return docRef.id;
    } catch (e) {
      print('Error creating garden task: $e');
      return null;
    }
  }

  // Create a new plant task
  Future<String?> createPlantTask(TaskModel task) async {
    try {
      final docRef = await _firestore.collection('plantTasks').add(task.toJson());
      return docRef.id;
    } catch (e) {
      print('Error creating plant task: $e');
      return null;
    }
  }

  // Update a garden task
  Future<bool> updateGardenTask(String taskId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('gardenTasks').doc(taskId).update(updates);
      return true;
    } catch (e) {
      print('Error updating garden task: $e');
      return false;
    }
  }

  // Update a plant task
  Future<bool> updatePlantTask(String taskId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('plantTasks').doc(taskId).update(updates);
      return true;
    } catch (e) {
      print('Error updating plant task: $e');
      return false;
    }
  }

  // Complete a garden task
  Future<bool> completeGardenTask(String taskId) async {
    try {
      await _firestore.collection('gardenTasks').doc(taskId).update({
        'isCompleted': true,
        'completedToday': true,
        'completedAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print('Error completing garden task: $e');
      return false;
    }
  }

  // Complete a plant task
  Future<bool> completePlantTask(String taskId) async {
    try {
      await _firestore.collection('plantTasks').doc(taskId).update({
        'isCompleted': true,
        'completedToday': true,
        'completedAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print('Error completing plant task: $e');
      return false;
    }
  }

  // Reset daily garden tasks
  Future<bool> resetDailyGardenTasks() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return false;

      final snapshot = await _firestore.collection('gardenTasks')
          .where('userId', isEqualTo: currentUser.uid)
          .where('completedToday', isEqualTo: true)
          .get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {
          'completedToday': false,
        });
      }

      await batch.commit();
      return true;
    } catch (e) {
      print('Error resetting daily garden tasks: $e');
      return false;
    }
  }

  // Reset daily plant tasks
  Future<bool> resetDailyPlantTasks() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return false;

      final snapshot = await _firestore.collection('plantTasks')
          .where('userId', isEqualTo: currentUser.uid)
          .where('completedToday', isEqualTo: true)
          .get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {
          'completedToday': false,
        });
      }

      await batch.commit();
      return true;
    } catch (e) {
      print('Error resetting daily plant tasks: $e');
      return false;
    }
  }

  // Delete a garden task
  Future<bool> deleteGardenTask(String taskId) async {
    try {
      await _firestore.collection('gardenTasks').doc(taskId).delete();
      return true;
    } catch (e) {
      print('Error deleting garden task: $e');
      return false;
    }
  }

  // Delete a plant task
  Future<bool> deletePlantTask(String taskId) async {
    try {
      await _firestore.collection('plantTasks').doc(taskId).delete();
      return true;
    } catch (e) {
      print('Error deleting plant task: $e');
      return false;
    }
  }

  // Get overdue tasks
  Future<List<TaskModel>> getOverdueTasks() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return [];

      final now = DateTime.now();
      final gardenTasks = await getUserGardenTasks();
      final plantTasks = await getUserPlantTasks();

      final allTasks = [...gardenTasks, ...plantTasks];
      return allTasks.where((task) => task.isOverdue).toList();
    } catch (e) {
      print('Error getting overdue tasks: $e');
      return [];
    }
  }

  // Get tasks due today
  Future<List<TaskModel>> getTasksDueToday() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return [];

      final gardenTasks = await getUserGardenTasks();
      final plantTasks = await getUserPlantTasks();

      final allTasks = [...gardenTasks, ...plantTasks];
      return allTasks.where((task) => task.isDueToday).toList();
    } catch (e) {
      print('Error getting tasks due today: $e');
      return [];
    }
  }
} 