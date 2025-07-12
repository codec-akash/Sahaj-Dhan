import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import '../../domain/entities/update_info.dart';

class UpdateCard extends StatelessWidget {
  final UpdateInfo updateInfo;
  final VoidCallback onUpdate;
  final VoidCallback onDismiss;

  const UpdateCard({
    super.key,
    required this.updateInfo,
    required this.onUpdate,
    required this.onDismiss,
  });

  String _getStatusText(InstallStatus status) {
    switch (status) {
      case InstallStatus.pending:
        return 'Waiting to start update...';
      case InstallStatus.downloading:
        return 'Downloading update...';
      case InstallStatus.installing:
        return 'Installing update...';
      case InstallStatus.installed:
        return 'Update installed successfully!';
      case InstallStatus.failed:
        return 'Update failed. Please try again.';
      case InstallStatus.canceled:
        return 'Update canceled.';
      case InstallStatus.downloaded:
        return 'Update downloaded. Installing...';
      case InstallStatus.unknown:
        return 'Unknown status';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('update_card'),
      onDismissed: (_) => onDismiss(),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Update Available (v${updateInfo.newVersion})',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onDismiss,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                updateInfo.changelog,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              if (updateInfo.installStatus != InstallStatus.unknown)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStatusText(updateInfo.installStatus),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                updateInfo.installStatus == InstallStatus.failed
                                    ? Colors.red
                                    : updateInfo.installStatus ==
                                            InstallStatus.installed
                                        ? Colors.green
                                        : Colors.blue,
                          ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              if (updateInfo.installStatus == InstallStatus.unknown ||
                  updateInfo.installStatus == InstallStatus.failed)
                ElevatedButton(
                  onPressed: onUpdate,
                  child: const Text('Update Now'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
