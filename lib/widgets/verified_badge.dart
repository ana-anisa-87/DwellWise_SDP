import 'package:flutter/material.dart';

/// Trust indicator badge representing verified property listings.
class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xff10B981).withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xff10B981).withOpacity(0.3)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, color: Color(0xff10B981), size: 14),
          SizedBox(width: 4),
          Text(
            'Verified',
            style: TextStyle(
              color: Color(0xff10B981),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
