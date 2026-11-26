import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_bloc.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_event.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_state.dart';
import '../../constants/app_constants.dart';
import '../widgets/medicine_card.dart';
import 'cart_screen.dart';
import 'medicine_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<PharmacyBloc, PharmacyState>(
      listenWhen: (prev, curr) => curr.orderSuccessMessage != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.orderSuccessMessage!)),
        );
        context.read<PharmacyBloc>().add(ClearOrderMessage());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppConstants.appName,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          actions: [
            BlocBuilder<PharmacyBloc, PharmacyState>(
              buildWhen: (prev, curr) => prev.isDarkMode != curr.isDarkMode,
              builder: (context, state) {
                return IconButton(
                  tooltip: state.isDarkMode ? 'Light Mode' : 'Dark Mode',
                  icon: Icon(
                    state.isDarkMode
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                  ),
                  onPressed: () {
                    context.read<PharmacyBloc>().add(ToggleTheme());
                  },
                );
              },
            ),
            BlocBuilder<PharmacyBloc, PharmacyState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          );
                        },
                      ),
                      if (state.totalCartCount > 0)
                        Positioned(
                          right: 6,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${state.totalCartCount}',
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
              child: TextField(
                onChanged: (value) =>
                    context.read<PharmacyBloc>().add(SearchMedicines(value)),
                decoration: InputDecoration(
                  hintText: 'ဆေးအမည် သို့မဟုတ် အမျိုးအစား ရှာဖွေရန်...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                ),
              ),
            ),
            BlocBuilder<PharmacyBloc, PharmacyState>(
              buildWhen: (prev, curr) =>
                  prev.selectedCategory != curr.selectedCategory,
              builder: (context, state) {
                return SizedBox(
                  height: 42,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: AppConstants.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = AppConstants.categories[index];
                      final isSelected = state.selectedCategory == category;
                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) => context
                            .read<PharmacyBloc>()
                            .add(SelectCategory(category)),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<PharmacyBloc, PharmacyState>(
                builder: (context, state) {
                  if (state.status == PharmacyStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == PharmacyStatus.error) {
                    return Center(
                      child: Text(state.errorMessage ?? 'Error occurred'),
                    );
                  }
                  if (state.filteredMedicines.isEmpty) {
                    return const Center(
                      child: Text('ကိုက်ညီသော ဆေးဝါး မတွေ့ရှိပါ။'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    itemCount: state.filteredMedicines.length,
                    itemBuilder: (context, index) {
                      final med = state.filteredMedicines[index];
                      final cartItem = state.cartItems
                          .where((c) => c.medicine.id == med.id)
                          .toList();
                      final qty =
                          cartItem.isEmpty ? 0 : cartItem.first.quantity;

                      return MedicineCard(
                        medicine: med,
                        cartQuantity: qty,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  MedicineDetailScreen(medicineId: med.id),
                            ),
                          );
                        },
                        onAdd: () =>
                            context.read<PharmacyBloc>().add(AddToCart(med)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}