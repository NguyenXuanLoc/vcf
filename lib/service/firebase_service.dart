import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  // Singleton pattern
  static final FirebaseService _FirebaseService = FirebaseService._internal();
  bool isConnect = false;

  factory FirebaseService() {
    return _FirebaseService;
  }

  FirebaseService._internal();

  Future<void> init() async {
    await Firebase.initializeApp();
  }
}
