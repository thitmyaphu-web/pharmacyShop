import 'package:pharmacyshop/models/medicine.dart';



abstract class PharmacyEvent {}

class LoadMedicines extends PharmacyEvent {}

class SearchMedicines extends PharmacyEvent {
  final String query;
  SearchMedicines(this.query);
}

class SelectCategory extends PharmacyEvent {
  final String category;
  SelectCategory(this.category);
}

class AddToCart extends PharmacyEvent {
  final Medicine medicine;
  AddToCart(this.medicine);
}

class UpdateCartQuantity extends PharmacyEvent {
  final String medicineId;
  final int newQuantity;

  UpdateCartQuantity({
    required this.medicineId,
    required this.newQuantity,
  });
}

class CheckoutOrder extends PharmacyEvent {}

class ClearOrderMessage extends PharmacyEvent {}

class ToggleTheme extends PharmacyEvent {}