import '../models/medicine.dart';
import '../services/medicine_service.dart';

class MedicineRepository {
  final MedicineService _service;

  MedicineRepository({MedicineService? service})
      : _service = service ?? MedicineService();

  Future<List<Medicine>> getMedicines() {
    return _service.fetchMedicines();
  }
}