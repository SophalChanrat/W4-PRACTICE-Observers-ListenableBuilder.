import 'package:flutter/material.dart';
import 'package:w4/2_download_app/ui/theme/theme.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  // TODO

  double get downloadedSize =>
      (controller.ressource.size * (controller.progress / 100)) * 100;
  double get downloadProgress => controller.progress * 100;

  IconData get tileIcon {
    if (controller.status == DownloadStatus.notDownloaded) {
      return Icons.download;
    } else if (controller.status == DownloadStatus.downloading) {
      return Icons.downloading;
    } else {
      return Icons.folder;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            tileColor: Colors.white,
            title: Text(controller.ressource.name),
            subtitle: controller.status == DownloadStatus.notDownloaded
                ? SizedBox(height: 10)
                : Text(
                    "${downloadProgress.toStringAsFixed(1)}% completed - ${downloadedSize.toStringAsFixed(1)} of ${controller.ressource.size.toStringAsFixed(1)}MB",
                  ),
            trailing: IconButton(
              onPressed: controller.startDownload,
              icon: Icon(tileIcon, color: AppColors.iconNormal),
            ),
          ),
        );
      },
    );
  }
}
