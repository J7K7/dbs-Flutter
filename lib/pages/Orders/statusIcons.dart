import 'dart:ui';

import 'package:flutter/material.dart';

class StatusInfo {
  final Color color;
  final IconData icon;

  StatusInfo({required this.color, required this.icon});
}

StatusInfo getStatusInfo(int statusCode) {
  switch (statusCode) {
    case 2:
      return StatusInfo(
        color: Color(0xFFf29229), // Matte yellow color for "Pending" status
        icon: Icons.pending, // Example icon for "Pending" status
      );
    case 3:
      return StatusInfo(
        color: Color(0xFF4e79b1), // Example color for "Confirmed" status
        icon: Icons.check_circle, // Example icon for "Confirmed" status
      );
    case 4:
      return StatusInfo(
        color: Colors.green, // Example color for "Completed" status
        icon: Icons.done_all_rounded, // Example icon for "Completed" status
      );
    case 5:
      return StatusInfo(
        color: Colors.red, // Example color for "Cancelled" status
        icon: Icons.cancel, // Example icon for "Cancelled" status
      );
    case 6:
      return StatusInfo(
        color: Color(0xFF8B0000), // Example color for "Rejected" status
        icon: Icons.cancel, // Example icon for "Rejected" status
      );
    default:
      return StatusInfo(
        color: Colors.grey, // Default color for unknown status
        icon: Icons.error, // Default icon for unknown status
      );
  }
}
