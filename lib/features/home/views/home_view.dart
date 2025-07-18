import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/garden_card.dart';
import '../widgets/task_list_item.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with user info
                  _buildHeader(),

                  const SizedBox(height: 24),

                  // Quick Actions
                  _buildQuickActions(),

                  const SizedBox(height: 24),

                  // Nearby Products Section
                  _buildNearbyProductsSection(),

                  const SizedBox(height: 24),

                  // My Gardens Section
                  _buildMyGardensSection(),

                  const SizedBox(height: 24),

                  // Tasks Section
                  _buildTasksSection(),

                  const SizedBox(height: 100), // Bottom padding for navigation
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(
          color: AppTheme.primaryColor.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // User Avatar
          CircleAvatar(
            radius: 30,
            backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
            backgroundImage: controller.currentUser?.photoUrl != null
                ? NetworkImage(controller.currentUser!.photoUrl!)
                : null,
            child: controller.currentUser?.photoUrl == null
                ? Icon(
                    Icons.person,
                    size: 30,
                    color: AppTheme.primaryColor,
                  )
                : null,
          ),

          const SizedBox(width: 16),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: AppTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.currentUser?.displayName ?? 'User',
                  style: AppTheme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryTextColor,
                  ),
                ),
                if (controller.hasLocation) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Location enabled',
                        style: AppTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Settings Button
          IconButton(
            onPressed: () => Get.toNamed('/settings'),
            icon: Icon(
              Icons.settings,
              color: AppTheme.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryTextColor,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.psychology,
                title: 'AI Assistant',
                subtitle: 'Get gardening help',
                onTap: controller.navigateToGpt,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.store,
                title: 'Marketplace',
                subtitle: 'Buy & sell produce',
                onTap: controller.navigateToMarketplace,
                color: AppTheme.secondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.eco,
                title: 'My Garden',
                subtitle: 'Manage gardens',
                onTap: controller.navigateToGarden,
                color: AppTheme.successColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.chat,
                title: 'Chat',
                subtitle: 'Connect with others',
                onTap: controller.navigateToChat,
                color: AppTheme.warningColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.hasLocation ? 'Nearby Products' : 'Recent Products',
              style: AppTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryTextColor,
              ),
            ),
            TextButton(
              onPressed: controller.navigateToMarketplace,
              child: Text(
                'View All',
                style: AppTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (controller.nearbyProducts.isEmpty)
          _buildEmptyState(
            icon: Icons.store,
            title: 'No products nearby',
            subtitle: 'Check back later for fresh produce',
          )
        else
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.nearbyProducts.length,
              itemBuilder: (context, index) {
                final product = controller.nearbyProducts[index];
                return ProductCard(
                  product: product,
                  onTap: () => controller.navigateToProductDetails(product),
                  showDistance: controller.hasLocation,
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildMyGardensSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Gardens',
              style: AppTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryTextColor,
              ),
            ),
            TextButton(
              onPressed: controller.navigateToGarden,
              child: Text(
                'View All',
                style: AppTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (controller.userGardens.isEmpty)
          _buildEmptyState(
            icon: Icons.eco,
            title: 'No gardens yet',
            subtitle: 'Create your first garden to get started',
            actionText: 'Create Garden',
            onAction: controller.navigateToGarden,
          )
        else
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.userGardens.length,
              itemBuilder: (context, index) {
                final garden = controller.userGardens[index];
                return GardenCard(
                  garden: garden,
                  onTap: () => controller.navigateToGardenDetails(garden),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildTasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Tasks',
          style: AppTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryTextColor,
          ),
        ),
        const SizedBox(height: 16),

        // Garden Tasks
        if (controller.userGardenTasks.isNotEmpty) ...[
          _buildTaskSectionHeader(
              'Garden Tasks', controller.completeSelectedGardenTasks),
          const SizedBox(height: 8),
          ...controller.userGardenTasks.map((task) => Obx(() {
                final isSelected = controller.isGardenTaskSelected(task.id);
                return TaskListItem(
                  task: task,
                  isSelected: isSelected,
                  onChanged: (value) =>
                      controller.toggleGardenTaskSelection(task.id),
                );
              })),
          const SizedBox(height: 16),
        ],

        // Plant Tasks
        if (controller.userPlantTasks.isNotEmpty) ...[
          _buildTaskSectionHeader(
              'Plant Tasks', controller.completeSelectedPlantTasks),
          const SizedBox(height: 8),
          ...controller.userPlantTasks.map((task) => Obx(() {
                final isSelected = controller.isPlantTaskSelected(task.id);
                return TaskListItem(
                  task: task,
                  isSelected: isSelected,
                  onChanged: (value) =>
                      controller.togglePlantTaskSelection(task.id),
                );
              })),
        ],

        // Empty state
        if (controller.userGardenTasks.isEmpty &&
            controller.userPlantTasks.isEmpty)
          _buildEmptyState(
            icon: Icons.task,
            title: 'No tasks for today',
            subtitle: 'All caught up! Check back tomorrow for new tasks',
          ),
      ],
    );
  }

  Widget _buildTaskSectionHeader(String title, VoidCallback onComplete) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryTextColor,
          ),
        ),
        Obx(() {
          final hasSelected = title == 'Garden Tasks'
              ? controller.hasSelectedGardenTasks()
              : controller.hasSelectedPlantTasks();

          if (!hasSelected) return const SizedBox.shrink();

          return CustomButton(
            text: 'Complete Selected',
            onPressed: onComplete,
            size: ButtonSize.small,
          );
        }),
      ],
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    String? actionText,
    VoidCallback? onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: AppTheme.secondaryTextColor,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          if (actionText != null && onAction != null) ...[
            const SizedBox(height: 16),
            CustomButton(
              text: actionText,
              onPressed: onAction,
              size: ButtonSize.medium,
            ),
          ],
        ],
      ),
    );
  }
}
