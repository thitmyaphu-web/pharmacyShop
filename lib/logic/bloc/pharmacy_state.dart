

import 'package:pharmacyshop/models/cart_item.dart';
import 'package:pharmacyshop/models/medicine.dart';

enum PharmacyStatus { initial, loading, loaded, error }

class PharmacyState {
  final PharmacyStatus status;
  final List<Medicine> allMedicines;
  final List<Medicine> filteredMedicines;
  final String selectedCategory;
  final String searchQuery;
  final List<CartItem> cartItems;
  final bool isDarkMode;
  final String? errorMessage;
  final String? orderSuccessMessage;

  const PharmacyState({
    this.status = PharmacyStatus.initial,
    this.allMedicines = const [],
    this.filteredMedicines = const [],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.cartItems = const [],
    this.isDarkMode = false,
    this.errorMessage,
    this.orderSuccessMessage,
  });

  int get totalCartCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  int get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.subtotal);

  PharmacyState copyWith({
    PharmacyStatus? status,
    List<Medicine>? allMedicines,
    List<Medicine>? filteredMedicines,
    String? selectedCategory,
    String? searchQuery,
    List<CartItem>? cartItems,
    bool? isDarkMode,
    String? errorMessage,
    String? orderSuccessMessage,
    bool clearOrderMessage = false,
  }) {
    return PharmacyState(
      status: status ?? this.status,
      allMedicines: allMedicines ?? this.allMedicines,
      filteredMedicines: filteredMedicines ?? this.filteredMedicines,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      cartItems: cartItems ?? this.cartItems,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      errorMessage: errorMessage ?? this.errorMessage,
      orderSuccessMessage: clearOrderMessage
          ? null
          : (orderSuccessMessage ?? this.orderSuccessMessage),
    );
  }
}