import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacyshop/models/cart_item.dart';
import 'package:pharmacyshop/models/medicine.dart';
import 'package:pharmacyshop/repositories/medicine_repository.dart';

import 'pharmacy_event.dart';
import 'pharmacy_state.dart';

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  final MedicineRepository _repository;

  PharmacyBloc({MedicineRepository? repository})
      : _repository = repository ?? MedicineRepository(),
        super(const PharmacyState()) {
    on<LoadMedicines>(_onLoadMedicines);
    on<SearchMedicines>(_onSearchMedicines);
    on<SelectCategory>(_onSelectCategory);
    on<AddToCart>(_onAddToCart);
    on<UpdateCartQuantity>(_onUpdateCartQuantity);
    on<CheckoutOrder>(_onCheckoutOrder);
    on<ClearOrderMessage>(_onClearOrderMessage);
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onLoadMedicines(
    LoadMedicines event,
    Emitter<PharmacyState> emit,
  ) async {
    emit(state.copyWith(status: PharmacyStatus.loading));
    try {
      final medicines = await _repository.getMedicines();
      emit(state.copyWith(
        status: PharmacyStatus.loaded,
        allMedicines: medicines,
        filteredMedicines: _applyFilters(
          medicines,
          state.selectedCategory,
          state.searchQuery,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PharmacyStatus.error,
        errorMessage: 'ဆေးစာရင်း ခေါ်ယူရာတွင် အမှားရှိနေပါသည်။',
      ));
    }
  }

  void _onSearchMedicines(
    SearchMedicines event,
    Emitter<PharmacyState> emit,
  ) {
    final updatedList = _applyFilters(
      state.allMedicines,
      state.selectedCategory,
      event.query,
    );
    emit(state.copyWith(
      searchQuery: event.query,
      filteredMedicines: updatedList,
    ));
  }

  void _onSelectCategory(
    SelectCategory event,
    Emitter<PharmacyState> emit,
  ) {
    final updatedList = _applyFilters(
      state.allMedicines,
      event.category,
      state.searchQuery,
    );
    emit(state.copyWith(
      selectedCategory: event.category,
      filteredMedicines: updatedList,
    ));
  }

  void _onAddToCart(
    AddToCart event,
    Emitter<PharmacyState> emit,
  ) {
    final index = state.cartItems
        .indexWhere((item) => item.medicine.id == event.medicine.id);
    final updatedCart = List<CartItem>.from(state.cartItems);

    if (index >= 0) {
      final current = updatedCart[index];
      if (current.quantity < event.medicine.stock) {
        updatedCart[index] = current.copyWith(quantity: current.quantity + 1);
      }
    } else if (event.medicine.stock > 0) {
      updatedCart.add(CartItem(medicine: event.medicine, quantity: 1));
    }

    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onUpdateCartQuantity(
    UpdateCartQuantity event,
    Emitter<PharmacyState> emit,
  ) {
    final updatedCart = <CartItem>[];
    for (final item in state.cartItems) {
      if (item.medicine.id == event.medicineId) {
        if (event.newQuantity > 0 && event.newQuantity <= item.medicine.stock) {
          updatedCart.add(item.copyWith(quantity: event.newQuantity));
        }
      } else {
        updatedCart.add(item);
      }
    }
    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onCheckoutOrder(
    CheckoutOrder event,
    Emitter<PharmacyState> emit,
  ) {
    if (state.cartItems.isEmpty) return;

    final updatedMedicines = state.allMedicines.map((med) {
      final matching =
          state.cartItems.where((c) => c.medicine.id == med.id).toList();
      if (matching.isEmpty) return med;
      final newStock =
          (med.stock - matching.first.quantity).clamp(0, med.stock);
      return med.copyWith(stock: newStock);
    }).toList();

    emit(state.copyWith(
      allMedicines: updatedMedicines,
      filteredMedicines: _applyFilters(
        updatedMedicines,
        state.selectedCategory,
        state.searchQuery,
      ),
      cartItems: const [],
      orderSuccessMessage: 'Order တင်ခြင်း အောင်မြင်ပါသည်။',
    ));
  }

  void _onClearOrderMessage(
    ClearOrderMessage event,
    Emitter<PharmacyState> emit,
  ) {
    emit(state.copyWith(clearOrderMessage: true));
  }

  void _onToggleTheme(
    ToggleTheme event,
    Emitter<PharmacyState> emit,
  ) {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  List<Medicine> _applyFilters(
    List<Medicine> source,
    String category,
    String query,
  ) {
    return source.where((med) {
      final matchesCategory = category == 'All' || med.category == category;
      final q = query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          med.name.toLowerCase().contains(q) ||
          med.category.toLowerCase().contains(q);
      return matchesCategory && matchesQuery;
    }).toList();
  }
}