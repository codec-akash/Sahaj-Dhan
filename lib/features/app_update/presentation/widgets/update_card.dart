import 'package:flutter/material.dart';
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
              if (updateInfo.status == UpdateStatus.downloading)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      value: updateInfo.downloadProgress,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Downloading: ${(updateInfo.downloadProgress * 100).toInt()}%',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                )
              else
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
