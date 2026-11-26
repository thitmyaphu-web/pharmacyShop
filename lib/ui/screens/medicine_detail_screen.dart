import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_bloc.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_event.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_state.dart';


class MedicineDetailScreen extends StatelessWidget {
  final String medicineId;

  const MedicineDetailScreen({super.key, required this.medicineId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<PharmacyBloc, PharmacyState>(
      builder: (context, state) {
        final med = state.allMedicines.firstWhere(
          (item) => item.id == medicineId,
        );
        final matching =
            state.cartItems.where((c) => c.medicine.id == med.id).toList();
        final cartQty = matching.isEmpty ? 0 : matching.first.quantity;
        final canAdd = med.stock > 0 && cartQty < med.stock;

        return Scaffold(
          appBar: AppBar(title: Text(med.name)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      med.category,
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      med.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${med.price} Ks • ${med.unit}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Available Stock: ${med.stock}',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      med.description,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                    ),
                    if (med.requiresPrescription) ...[
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'ဤဆေးဝါးသည် ဆရာဝန် ညွှန်ကြားချက်ဖြင့်သာ အသုံးပြုသင့်သော ဆေးဖြစ်ပါသည်။',
                          style: TextStyle(
                            color: Colors.amber.shade900,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: canAdd
                            ? () =>
                                context.read<PharmacyBloc>().add(AddToCart(med))
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          cartQty > 0
                              ? 'Add to Cart ($cartQty in cart)'
                              : 'Add to Cart',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}