import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';

import 'dashboard/dashboard_shell.dart';

void main() => runApp(const DashboardApp());

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlyphTheme.light(),
      home: const DashboardShell(),
    );
  }
}
