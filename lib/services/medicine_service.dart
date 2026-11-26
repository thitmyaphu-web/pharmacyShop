import '../models/medicine.dart';

class MedicineService {
  static const _sampleMedicines = [
    Medicine(
      id: 'med_1',
      name: 'Paracetamol 500mg',
      category: 'Fever & Pain',
      unit: '10 Tablets / Strip',
      price: 1500,
      stock: 25,
      requiresPrescription: false,
      description: 'အဖျားကျခြင်းနှင့် အကိုက်အခဲ သက်သာစေရန် အသုံးပြုသော ဆေးပြား။',
    ),
    Medicine(
      id: 'med_2',
      name: 'Vitamin C 1000mg',
      category: 'Vitamins',
      unit: '30 Tablets / Bottle',
      price: 8500,
      stock: 12,
      requiresPrescription: false,
      description: 'ကိုယ်ခံအား ထောက်ပံ့ရန် ဗီတာမင် စီ ဖြည့်စွက်ဆေး။',
    ),
    Medicine(
      id: 'med_3',
      name: 'Amoxicillin 500mg',
      category: 'Antibiotics',
      unit: '10 Capsules / Strip',
      price: 4500,
      stock: 8,
      requiresPrescription: true,
      description: 'ဆရာဝန် ညွှန်ကြားချက်ဖြင့်သာ အသုံးပြုသင့်သော ပဋိဇီဝဆေး။',
    ),
    Medicine(
      id: 'med_4',
      name: 'Cetirizine 10mg',
      category: 'Allergy',
      unit: '10 Tablets / Strip',
      price: 2000,
      stock: 18,
      requiresPrescription: false,
      description: 'ဓာတ်မတည့်ခြင်းနှင့် နှာစေးယားယံခြင်းအတွက် ဆေးပြား။',
    ),
  ];

  Future<List<Medicine>> fetchMedicines() async {
    return _sampleMedicines;
  }
}