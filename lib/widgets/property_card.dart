import 'package:flutter/material.dart';
import '../models/property_model.dart';
import 'verified_badge.dart';

/// Reusable card displaying real-estate listing overview metrics.
class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onTap;

  const PropertyCard({
    Key? key,
    required this.property,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image / Thumbnail container
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xff0F766E).withOpacity(0.08),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.home_work_outlined, size: 48, color: Color(0xff0F766E)),
                  ),
                  if (property.isVerified)
                    const Positioned(
                      top: 12,
                      left: 12,
                      child: VerifiedBadge(),
                    ),
                ],
              ),
            ),
            
            // Detail attributes
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        property.area.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xff0F766E),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        '৳${property.price.toInt()} / mo',
                        style: const TextStyle(
                          color: Color(0xff0F766E),
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    property.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff1E293B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${property.beds} BHK • ${property.baths} Bath • ${property.sizeSqFt.toInt()} sqft',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
