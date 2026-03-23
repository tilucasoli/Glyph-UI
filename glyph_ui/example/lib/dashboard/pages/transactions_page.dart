import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';

// ── Data model ────────────────────────────────────────────────────────────────

class _TxRow {
  const _TxRow({
    required this.id,
    required this.merchant,
    required this.amount,
    required this.status,
    required this.date,
  });

  final String id;
  final String merchant;
  final String amount;
  final String status;
  final String date;
}

// ── Dummy data ────────────────────────────────────────────────────────────────

const _kRows = <_TxRow>[
  _TxRow(
    id: 'TXN-001842',
    merchant: 'Stripe Inc.',
    amount: r'$4,200.00',
    status: 'Successful',
    date: '20 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001841',
    merchant: 'Shopify Payments',
    amount: r'$1,540.00',
    status: 'Successful',
    date: '20 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001840',
    merchant: 'Braintree LLC',
    amount: r'$320.50',
    status: 'Pending',
    date: '19 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001839',
    merchant: 'Square Inc.',
    amount: r'$8,900.00',
    status: 'Successful',
    date: '19 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001838',
    merchant: 'PayPal Holdings',
    amount: r'$215.00',
    status: 'Failed',
    date: '18 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001837',
    merchant: 'Adyen N.V.',
    amount: r'$3,100.00',
    status: 'Successful',
    date: '18 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001836',
    merchant: 'Worldpay Group',
    amount: r'$670.00',
    status: 'Pending',
    date: '17 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001835',
    merchant: 'Checkout.com',
    amount: r'$12,400.00',
    status: 'Successful',
    date: '17 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001834',
    merchant: 'Klarna Bank AB',
    amount: r'$890.00',
    status: 'Successful',
    date: '16 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001833',
    merchant: 'Affirm Inc.',
    amount: r'$550.00',
    status: 'Failed',
    date: '16 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001832',
    merchant: 'Razorpay Pvt',
    amount: r'$1,230.00',
    status: 'Successful',
    date: '15 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001831',
    merchant: 'Mollie B.V.',
    amount: r'$780.00',
    status: 'Successful',
    date: '15 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001830',
    merchant: 'GoCardless Ltd',
    amount: r'$2,050.00',
    status: 'Pending',
    date: '14 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001829',
    merchant: 'Paysafe Group',
    amount: r'$340.00',
    status: 'Successful',
    date: '14 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001828',
    merchant: 'Nuvei Corp',
    amount: r'$5,600.00',
    status: 'Successful',
    date: '13 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001827',
    merchant: 'Shift4 Payments',
    amount: r'$490.00',
    status: 'Failed',
    date: '13 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001826',
    merchant: 'WEX Inc.',
    amount: r'$1,870.00',
    status: 'Successful',
    date: '12 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001825',
    merchant: 'i2c Inc.',
    amount: r'$920.00',
    status: 'Pending',
    date: '12 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001824',
    merchant: 'Flutterwave Inc.',
    amount: r'$3,300.00',
    status: 'Successful',
    date: '11 Mar 2026',
  ),
  _TxRow(
    id: 'TXN-001823',
    merchant: 'Marqeta Inc.',
    amount: r'$7,150.00',
    status: 'Successful',
    date: '11 Mar 2026',
  ),
];

// ── Status badge helper ───────────────────────────────────────────────────────

GlyphBadgeStyle _badgeStyleForStatus(String status) => switch (status) {
  'Successful' => GlyphBadgeStyle.success(),
  'Pending' => GlyphBadgeStyle.attention(),
  _ => GlyphBadgeStyle.critical(),
};

// ── Page ──────────────────────────────────────────────────────────────────────

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  int _currentPage = 1;
  String _statusFilter = 'All';
  String _periodFilter = 'This month';
  final _searchController = TextEditingController();

  static const int _itemsPerPage = 10;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_TxRow> get _visibleRows => _kRows
      .skip((_currentPage - 1) * _itemsPerPage)
      .take(_itemsPerPage)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── App bar ──────────────────────────────────────────────────────────
        GlyphAppBar(
          style: GlyphAppBarStyle.standard(),
          breadcrumbs: const ['Ledger', 'Transactions'],
          actions: [
            GlyphIconButton(
              icon: const Icon(Icons.download_outlined),
              onPressed: () {},
              semanticLabel: 'Export transactions',
              style: GlyphIconButtonStyle.stroke(),
              size: .small,
            ),
          ],
        ),

        // ── Scrollable content ───────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Spacing.x6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── KPI cards ─────────────────────────────────────────────
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: Spacing.x4,
                    children: [
                      Expanded(
                        child: _KpiCard(
                          label: 'Total Revenue',
                          value: r'$284,920',
                          badge: const GlyphBadge(
                            label: '↑ 12.4%',
                            style: GlyphBadgeStyle.success(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _KpiCard(
                          label: 'Pending',
                          value: r'$18,340',
                          badge: const GlyphBadge(
                            label: '23 invoices',
                            style: GlyphBadgeStyle.attention(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _KpiCard(
                          label: 'Successful',
                          value: '1,842',
                          badge: const GlyphBadge(
                            label: 'This month',
                            style: GlyphBadgeStyle.success(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _KpiCard(
                          label: 'Failed',
                          value: '14',
                          badge: const GlyphBadge(
                            label: 'Needs review',
                            style: GlyphBadgeStyle.critical(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: Spacing.x6),

                // ── Filters ───────────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: Spacing.x3,
                  children: [
                    Expanded(
                      child: GlyphTextField(
                        label: 'Search',
                        style: GlyphTextFieldStyle.stroke(),
                        controller: _searchController,
                        placeholder: 'Search transactions…',
                        // trailing: const Icon(Icons.search_outlined),
                      ),
                    ),
                    GlyphDropdown<String>(
                      triggerStyle: GlyphDropdownTriggerStyle.stroke(),
                      items: const [
                        GlyphDropdownItem(value: 'All', label: 'All'),
                        GlyphDropdownItem(
                          value: 'Successful',
                          label: 'Successful',
                        ),
                        GlyphDropdownItem(value: 'Pending', label: 'Pending'),
                        GlyphDropdownItem(value: 'Failed', label: 'Failed'),
                      ],
                      value: _statusFilter,
                      onChanged: (v) => setState(() => _statusFilter = v),
                      placeholder: 'Status',
                      minWidth: 160,
                    ),
                    GlyphDropdown<String>(
                      triggerStyle: GlyphDropdownTriggerStyle.stroke(),
                      items: const [
                        GlyphDropdownItem(
                          value: 'This month',
                          label: 'This month',
                        ),
                        GlyphDropdownItem(
                          value: 'Last 30 days',
                          label: 'Last 30 days',
                        ),
                        GlyphDropdownItem(value: 'Q1 2026', label: 'Q1 2026'),
                        GlyphDropdownItem(value: 'All time', label: 'All time'),
                      ],
                      value: _periodFilter,
                      onChanged: (v) => setState(() => _periodFilter = v),
                      placeholder: 'Period',
                      minWidth: 160,
                    ),
                  ],
                ),

                const SizedBox(height: Spacing.x4),

                // ── Table ─────────────────────────────────────────────────
                GlyphDataTable<_TxRow>(
                  style: GlyphDataTableStyle.standard(),
                  columns: [
                    GlyphColumn<_TxRow>(
                      header: 'Transaction ID',
                      fixedWidth: 140,
                      cell: (row) => Text(
                        row.id,
                        style: GlyphTextStyles.labelXsmall.copyWith(
                          color: GlyphColors.contentSubtle,
                        ),
                      ),
                    ),
                    GlyphColumn<_TxRow>(
                      header: 'Merchant',
                      flex: 2,
                      cell: (row) => Text(
                        row.merchant,
                        style: GlyphTextStyles.paragraphSmall,
                      ),
                    ),
                    GlyphColumn<_TxRow>(
                      header: 'Amount',
                      fixedWidth: 110,
                      cell: (row) => Text(
                        row.amount,
                        style: GlyphTextStyles.labelSmallStrong,
                      ),
                    ),
                    GlyphColumn<_TxRow>(
                      header: 'Status',
                      flex: 1,
                      cell: (row) => GlyphBadge(
                        label: row.status,
                        style: _badgeStyleForStatus(row.status),
                      ),
                    ),
                    GlyphColumn<_TxRow>(
                      header: 'Date',
                      fixedWidth: 120,
                      cell: (row) => Text(
                        row.date,
                        style: GlyphTextStyles.labelXsmall.copyWith(
                          color: GlyphColors.contentSubtle,
                        ),
                      ),
                    ),
                  ],
                  rows: _visibleRows,
                  footer: GlyphPagination(
                    style: GlyphPaginationStyle.standard(),
                    currentPage: _currentPage,
                    totalItems: _kRows.length,
                    itemsPerPage: _itemsPerPage,
                    onPrevious: _currentPage > 1
                        ? () => setState(() => _currentPage--)
                        : null,
                    onNext: _currentPage * _itemsPerPage < _kRows.length
                        ? () => setState(() => _currentPage++)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── KPI card widget ───────────────────────────────────────────────────────────

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.label,
    required this.value,
    required this.badge,
  });

  final String label;
  final String value;
  final Widget badge;

  @override
  Widget build(BuildContext context) {
    return GlyphCard(
      style: GlyphCardStyle.surface(),
      size: .medium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GlyphTextStyles.labelXsmall.copyWith(
              color: GlyphColors.contentSubtle,
            ),
          ),
          const SizedBox(height: Spacing.x1),
          Text(value, style: GlyphTextStyles.titleXsmall),
          const SizedBox(height: Spacing.x2),
          badge,
        ],
      ),
    );
  }
}
