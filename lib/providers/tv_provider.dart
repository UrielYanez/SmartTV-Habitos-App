import 'package:flutter/material.dart';

class TvProvider extends ChangeNotifier {
  bool _isPaired = false;
  String _pairingCode = "1A2B3C"; // Mock code para demostración

  // Mock de estadísticas
  int _streakDays = 14;
  int _completedHabits = 128;
  int _successRate = 85;

  bool get isPaired => _isPaired;
  String get pairingCode => _pairingCode;
  
  int get streakDays => _streakDays;
  int get completedHabits => _completedHabits;
  int get successRate => _successRate;

  Future<void> init() async {
    // Aquí iría la lógica para cargar el estado guardado o conectar con Firebase
    notifyListeners();
  }

  // Método temporal para simular vinculación
  void simulatePairing() {
    _isPaired = true;
    notifyListeners();
  }

  // Método temporal para simular desvinculación
  void simulateUnpairing() {
    _isPaired = false;
    notifyListeners();
  }
}
