import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_bloc.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_event.dart';
import 'package:pharmacyshop/logic/bloc/pharmacy_state.dart';
import 'constants/app_constants.dart';

import 'ui/screens/home_screen.dart';

void main() {
  runApp(const MediShopApp());
}

class MediShopApp extends StatelessWidget {
  const MediShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PharmacyBloc()..add(LoadMedicines()),
      child: BlocBuilder<PharmacyBloc, PharmacyState>(
        buildWhen: (prev, curr) => prev.isDarkMode != curr.isDarkMode,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppConstants.lightTheme,
            darkTheme: AppConstants.darkTheme,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}