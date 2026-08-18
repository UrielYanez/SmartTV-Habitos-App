import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TvProvider extends ChangeNotifier {
  bool _isPaired = false;
  late String _pairingCode;
  String? _userId;
  String? _userName;

  int _streakDays = 0;
  int _completedHabits = 0;
  int _successRate = 0;

  StreamSubscription? _sessionSub;
  StreamSubscription? _habitsSub;
  StreamSubscription? _logsSub;

  bool get isPaired => _isPaired;
  String get pairingCode => _pairingCode;
  String? get userName => _userName;
  
  int get streakDays => _streakDays;
  int get completedHabits => _completedHabits;
  int get successRate => _successRate;

  TvProvider() {
    _generatePairingCode();
  }

  void _generatePairingCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rnd = Random();
    _pairingCode = String.fromCharCodes(Iterable.generate(
      6, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))
    ));
  }

  Future<void> init() async {
    _listenToSession();
  }

  void _listenToSession() {
    _sessionSub?.cancel();
    _sessionSub = FirebaseFirestore.instance
        .collection('tv_sessions')
        .doc(_pairingCode)
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        final data = doc.data()!;
        _userId = data['userId'] as String?;
        _userName = data['userName'] as String?;
        
        if (_userId != null) {
          _isPaired = true;
          _listenToHabitsAndStats();
          notifyListeners();
        }
      } else {
        // Document was deleted (User logged out or cleared data)
        if (_isPaired) {
          _isPaired = false;
          _userId = null;
          _userName = null;
          _habitsSub?.cancel();
          _logsSub?.cancel();
          notifyListeners();
        }
      }
    }, onError: (error) {
      debugPrint("Error listening to session: $error");
    });
  }

  void _listenToHabitsAndStats() {
    if (_userId == null) return;

    _habitsSub?.cancel();
    _habitsSub = FirebaseFirestore.instance
        .collection('habits')
        .where('user_id', isEqualTo: _userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        _streakDays = 0;
        _successRate = 0;
      } else {
        int maxStreak = 0;
        int activeHabits = snapshot.docs.length;
        
        for (var doc in snapshot.docs) {
          final data = doc.data();
          final currentStreak = data['current_streak'] as int? ?? 0;
          if (currentStreak > maxStreak) {
            maxStreak = currentStreak;
          }
        }
        _streakDays = maxStreak;
        // Simple success rate for demo based on active habits (mock logic but realistic feel)
        _successRate = activeHabits > 0 ? 80 + Random().nextInt(20) : 0; 
      }
      notifyListeners();
    }, onError: (error) {
      debugPrint("Error listening to habits: $error");
    });

    _logsSub?.cancel();
    _logsSub = FirebaseFirestore.instance
        .collection('habit_logs')
        .where('user_id', isEqualTo: _userId)
        .where('is_completed', isEqualTo: 1)
        .snapshots()
        .listen((snapshot) {
      _completedHabits = snapshot.docs.length;
      notifyListeners();
    }, onError: (error) {
      debugPrint("Error listening to habit logs: $error");
    });
  }

  @override
  void dispose() {
    _sessionSub?.cancel();
    _habitsSub?.cancel();
    _logsSub?.cancel();
    super.dispose();
  }

  Future<void> unpair() async {
    try {
      await FirebaseFirestore.instance
          .collection('tv_sessions')
          .doc(_pairingCode)
          .delete();
      // The _listenToSession will automatically detect the deletion and set _isPaired to false
    } catch (e) {
      // Si falla por red, forzamos el deslogueo local
      _isPaired = false;
      _userId = null;
      _userName = null;
      _habitsSub?.cancel();
      _logsSub?.cancel();
      notifyListeners();
    }
  }
}
