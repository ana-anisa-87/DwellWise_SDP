import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/admin_provider.dart';
import '../../widgets/property_card.dart';

/// Screen listing properties pending verification checks.
class AdminPendingListingsScreen extends StatefulWidget {
  const AdminPendingListingsScreen({Key? key}) : super(key: key);

  @override
  State<AdminPendingListingsScreen> createState() => _AdminPendingListingsScreenState();
}

class _AdminPendingListingsScreenState extends State<AdminPendingListingsScreen> {
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
    final pending = adminProvider.pendingListings;

    return Scaffold(
      appBar: AppBar(title: const Text('Pending Approvals')),
      body: pending.isEmpty
          ? const Center(child: Text('No properties awaiting review.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pending.length,
              itemBuilder: (context, index) {
                final property = pending[index];
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
                              const SnackBar(content: Text('Listing rejected.')),
                            );
                          },
                          child: const Text('Reject', style: TextStyle(color: Colors.red)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            adminProvider.approveListing(property.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Listing approved and published.')),
                            );
                          },
                          child: const Text('Approve'),
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
