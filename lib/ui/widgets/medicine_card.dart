import 'package:flutter/material.dart';
import '../../models/medicine.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final int cartQuantity;
  final VoidCallback onTap;
  final VoidCallback? onAdd;

  const MedicineCard({
    super.key,
    required this.medicine,
    required this.cartQuantity,
    required this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isOutOfStock = medicine.stock <= 0;
    final isMaxReached = cartQuantity >= medicine.stock;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: medicine.imageUrl.isNotEmpty
                      ? Image.network(
                          medicine.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _fallbackIcon(colorScheme),
                        )
                      : _fallbackIcon(colorScheme),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${medicine.category} • ${medicine.unit}',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '${medicine.price} Ks',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isOutOfStock ? 'Out of stock' : 'Stock: ${medicine.stock}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isOutOfStock
                                ? colorScheme.error
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.tonal(
                onPressed: (isOutOfStock || isMaxReached) ? null : onAdd,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(cartQuantity > 0 ? 'Add ($cartQuantity)' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fallbackIcon(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.primaryContainer,
      child: Icon(Icons.cake_rounded, color: colorScheme.primary, size: 32),
    );
  }
}