import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/admin_provider.dart';
import '../../widgets/property_card.dart';

/// Screen listing properties reported for violations.
class AdminReportedListingsScreen extends StatefulWidget {
  const AdminReportedListingsScreen({Key? key}) : super(key: key);

  @override
  State<AdminReportedListingsScreen> createState() => _AdminReportedListingsScreenState();
}

class _AdminReportedListingsScreenState extends State<AdminReportedListingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().fetchModerationQueues();
    });
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = context.watch<AdminProvider>();
    final reported = adminProvider.reportedListings;

    return Scaffold(
      appBar: AppBar(title: const Text('Reported Violations')),
      body: reported.isEmpty
          ? const Center(child: Text('No active violation flags.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reported.length,
              itemBuilder: (context, index) {
                final property = reported[index];
                return Column(
                  children: [
                    PropertyCard(property: property),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            adminProvider.rejectListing(property.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Flag cleared.')),
                            );
                          },
                          child: const Text('Dismiss Flag'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            adminProvider.rejectListing(property.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Listing blocked and deleted.')),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text('Block Listing'),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
    );
  }
}
