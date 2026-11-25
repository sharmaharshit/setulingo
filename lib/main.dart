import 'package:flutter/material.dart';

import 'app.dart';
import 'services/persistence_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final persistence = await PersistenceService.create();
  runApp(SetuLingoApp(persistence: persistence));
}
