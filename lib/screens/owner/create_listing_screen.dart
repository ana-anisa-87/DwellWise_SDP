import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/property_provider.dart';
import '../../models/property_model.dart';
import '../../widgets/custom_button.dart';

/// Stepper screen to register a new property rental listing.
class OwnerCreateListingScreen extends StatefulWidget {
  const OwnerCreateListingScreen({Key? key}) : super(key: key);

  @override
  State<OwnerCreateListingScreen> createState() => _OwnerCreateListingScreenState();
}

class _OwnerCreateListingScreenState extends State<OwnerCreateListingScreen> {
  int _currentStep = 0;

  final _titleController = TextEditingController();
  final _areaController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _areaController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitListing() async {
    final provider = context.read<PropertyProvider>();
    final newProperty = PropertyModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.tryParse(_priceController.text) ?? 25000,
      area: _areaController.text.trim(),
      address: '${_areaController.text.trim()}, Dhaka',
      latitude: 23.7925,
      longitude: 90.4078,
      beds: 2,
      baths: 2,
      sizeSqFt: 1200,
      imageUrls: [],
      isVerified: false,
      ownerId: 'o1',
      facilities: ['Wifi', 'Lift'],
      createdAt: DateTime.now(),
    );

    final success = await provider.addProperty(newProperty);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property created! Pending verification.')),
      );
      context.go('/owner-home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<PropertyProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Listing')),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() => _currentStep++);
                } else {
                  _submitListing();
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep--);
                }
              },
              steps: [
                Step(
                  title: const Text('Core Details'),
                  isActive: _currentStep == 0,
                  content: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Listing Title'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _areaController,
                        decoration: const InputDecoration(labelText: 'Area / Neighborhood'),
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Pricing & Size'),
                  isActive: _currentStep == 1,
                  content: Column(
                    children: [
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Expected Rent (BDT)'),
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Description'),
                  isActive: _currentStep == 2,
                  content: Column(
                    children: [
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(labelText: 'Listing Description'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
