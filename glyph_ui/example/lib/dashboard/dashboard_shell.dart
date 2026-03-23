import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';

import 'pages/invoices_page.dart';
import 'pages/settings_page.dart';
import 'pages/transactions_page.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GlyphScaffold(
      style: GlyphScaffoldStyle.standard(),
      sidebar: GlyphSidebar(
        style: GlyphSidebarStyle.standard(),
        brandName: 'Ledger',
        brandIcon: const Icon(Icons.account_balance_outlined),
        groups: [
          GlyphNavGroup(
            title: 'Finance',
            items: [
              GlyphSidebarItem(
                icon: const Icon(Icons.swap_horiz_outlined),
                label: 'Transactions',
                isActive: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
              ),
              GlyphSidebarItem(
                icon: const Icon(Icons.receipt_long_outlined),
                label: 'Invoices',
                isActive: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
              GlyphSidebarItem(
                icon: const Icon(Icons.bar_chart_outlined),
                label: 'Reports',
                isActive: _selectedIndex == 2,
                onTap: () => setState(() => _selectedIndex = 2),
              ),
            ],
          ),
          GlyphNavGroup(
            title: 'Account',
            items: [
              GlyphSidebarItem(
                icon: const Icon(Icons.group_outlined),
                label: 'Team',
                isActive: _selectedIndex == 3,
                onTap: () => setState(() => _selectedIndex = 3),
              ),
              GlyphSidebarItem(
                icon: const Icon(Icons.settings_outlined),
                label: 'Settings',
                isActive: _selectedIndex == 4,
                onTap: () => setState(() => _selectedIndex = 4),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return switch (_selectedIndex) {
      0 => const TransactionsPage(),
      1 => const InvoicesPage(),
      4 => const SettingsPage(),
      _ => _PlaceholderPage(label: _labelForIndex(_selectedIndex)),
    };
  }

  String _labelForIndex(int index) => switch (index) {
    1 => 'Invoices',
    2 => 'Reports',
    3 => 'Team',
    4 => 'Settings',
    _ => 'Page',
  };
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: GlyphTextStyles.titleSmall.copyWith(
          color: GlyphColors.contentSubtle,
        ),
      ),
    );
  }
}
