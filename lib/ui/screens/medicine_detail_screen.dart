import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_bloc.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_event.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_state.dart';

import '../../models/medicine.dart';

class MedicineDetailScreen extends StatelessWidget {
  final Medicine medicine;

  const MedicineDetailScreen({super.key, required this.medicine, required String medicineId});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<PharmacyBloc, PharmacyState>(
      builder: (context, state) {
        final currentMed = state.allMedicines.firstWhere(
          (m) => m.id == medicine.id,
          orElse: () => medicine,
        );
        final cartItem = state.cartItems
            .where((item) => item.medicine.id == currentMed.id)
            .firstOrNull;
        final cartQty = cartItem?.quantity ?? 0;
        final canAdd = currentMed.stock > 0 && cartQty < currentMed.stock;

        return Scaffold(
          appBar: AppBar(title: const Text('Cake Details')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Large Cake Banner Image
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: currentMed.imageUrl.isNotEmpty
                      ? Image.network(
                          currentMed.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: colorScheme.primaryContainer,
                            child: Icon(
                              Icons.cake_rounded,
                              size: 64,
                              color: colorScheme.primary,
                            ),
                          ),
                        )
                      : Container(
                          color: colorScheme.primaryContainer,
                          child: Icon(
                            Icons.cake_rounded,
                            size: 64,
                            color: colorScheme.primary,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 18),

              // Info Card
              Card(
                elevation: 0,
                color: colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(color: colorScheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentMed.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${currentMed.category} • ${currentMed.unit}',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${currentMed.price} Ks',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          Chip(
                            label: Text('Available: ${currentMed.stock}'),
                          ),
                        ],
                      ),
                      const Divider(height: 28),
                      const Text(
                        'Description & Recipe Notes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentMed.description,
                        style: TextStyle(
                          height: 1.5,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                onPressed: canAdd
                    ? () {
                        context.read<PharmacyBloc>().add(AddToCart(currentMed));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${currentMed.name} to cart'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.shopping_bag_outlined),
                label: Text(
                  cartQty > 0
                      ? 'Add More to Cart ($cartQty in cart)'
                      : 'Add to Cart',
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}