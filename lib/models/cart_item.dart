import 'medicine.dart';

class CartItem {
  final Medicine medicine;
  final int quantity;

  const CartItem({
    required this.medicine,
    required this.quantity,
  });

  int get subtotal => medicine.price * quantity;

  CartItem copyWith({
    Medicine? medicine,
    int? quantity,
  }) {
    return CartItem(
      medicine: medicine ?? this.medicine,
      quantity: quantity ?? this.quantity,
    );
  }
}