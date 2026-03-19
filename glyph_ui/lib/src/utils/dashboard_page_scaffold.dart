import 'package:flutter/widgets.dart';

import '../components/scaffold/glyph_app_bar.dart';
import '../tokens/glyph_spacing.dart';

class DashboardPageScaffold extends StatelessWidget {
  const DashboardPageScaffold({super.key, this.appBar, required this.body});

  final GlyphAppBar? appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (appBar != null) appBar!,
        Padding(padding: EdgeInsets.all(GlyphSpacing.s8), child: body),
      ],
    );
  }
}
