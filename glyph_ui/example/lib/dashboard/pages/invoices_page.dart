import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';

// ── Data model ────────────────────────────────────────────────────────────────

class _InvoiceRow {
  const _InvoiceRow({
    required this.number,
    required this.client,
    required this.amount,
    required this.status,
    required this.issued,
    required this.due,
  });

  final String number;
  final String client;
  final String amount;
  final String status;
  final String issued;
  final String due;
}

// ── Dummy data ────────────────────────────────────────────────────────────────

const _kInvoices = <_InvoiceRow>[
  _InvoiceRow(
    number: 'INV-2026-0042',
    client: 'Acme Corp',
    amount: r'$12,400.00',
    status: 'Paid',
    issued: '01 Mar 2026',
    due: '15 Mar 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0041',
    client: 'Globex Solutions',
    amount: r'$8,750.00',
    status: 'Overdue',
    issued: '20 Feb 2026',
    due: '06 Mar 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0040',
    client: 'Initech Ltd',
    amount: r'$3,200.00',
    status: 'Sent',
    issued: '10 Mar 2026',
    due: '24 Mar 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0039',
    client: 'Umbrella Inc.',
    amount: r'$5,600.00',
    status: 'Paid',
    issued: '05 Mar 2026',
    due: '19 Mar 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0038',
    client: 'Weyland Corp',
    amount: r'$920.00',
    status: 'Draft',
    issued: '18 Mar 2026',
    due: '01 Apr 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0037',
    client: 'Stark Industries',
    amount: r'$21,000.00',
    status: 'Sent',
    issued: '12 Mar 2026',
    due: '26 Mar 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0036',
    client: 'Veridian Dynamics',
    amount: r'$4,150.00',
    status: 'Overdue',
    issued: '15 Feb 2026',
    due: '01 Mar 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0035',
    client: 'Soylent Corp',
    amount: r'$680.00',
    status: 'Paid',
    issued: '28 Feb 2026',
    due: '13 Mar 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0034',
    client: 'Buy n Large',
    amount: r'$14,300.00',
    status: 'Draft',
    issued: '19 Mar 2026',
    due: '02 Apr 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0033',
    client: 'Cyberdyne Systems',
    amount: r'$7,800.00',
    status: 'Sent',
    issued: '08 Mar 2026',
    due: '22 Mar 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0032',
    client: 'Oscorp Industries',
    amount: r'$2,450.00',
    status: 'Paid',
    issued: '01 Mar 2026',
    due: '15 Mar 2026',
  ),
  _InvoiceRow(
    number: 'INV-2026-0031',
    client: 'Massive Dynamic',
    amount: r'$9,600.00',
    status: 'Overdue',
    issued: '10 Feb 2026',
    due: '24 Feb 2026',
  ),
];

// ── Badge style helper ────────────────────────────────────────────────────────

GlyphBadgeStyle _badgeForStatus(String status) => switch (status) {
  'Paid' => const GlyphBadgeStyle.success(),
  'Sent' => const GlyphBadgeStyle.accent(),
  'Overdue' => const GlyphBadgeStyle.critical(),
  _ => const GlyphBadgeStyle.neutral(), // Draft
};

// ── Page ──────────────────────────────────────────────────────────────────────

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  int _currentPage = 1;
  String _statusFilter = 'All';
  final _searchController = TextEditingController();

  static const int _itemsPerPage = 10;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_InvoiceRow> get _filteredRows {
    final query = _searchController.text.toLowerCase();
    return _kInvoices.where((r) {
      final matchesStatus =
          _statusFilter == 'All' || r.status == _statusFilter;
      final matchesQuery = query.isEmpty ||
          r.number.toLowerCase().contains(query) ||
          r.client.toLowerCase().contains(query);
      return matchesStatus && matchesQuery;
    }).toList();
  }

  List<_InvoiceRow> get _visibleRows => _filteredRows
      .skip((_currentPage - 1) * _itemsPerPage)
      .take(_itemsPerPage)
      .toList();

  int get _totalFiltered => _filteredRows.length;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── App bar ──────────────────────────────────────────────────────────
        GlyphAppBar(
          style: GlyphAppBarStyle.standard(),
          breadcrumbs: const ['Ledger', 'Invoices'],
          actions: [
            GlyphButton(
              label: 'New Invoice',
              onPressed: () {},
              style: GlyphButtonStyle.filled(),
              size: .medium,
              leadingIcon: const Icon(Icons.add),
            ),
            GlyphIconButton(
              icon: const Icon(Icons.download_outlined),
              onPressed: () {},
              semanticLabel: 'Export invoices',
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
                // ── KPI summary ───────────────────────────────────────────
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: Spacing.x4,
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          label: 'Total Invoiced',
                          value: r'$90,850',
                          detail: '12 invoices',
                          accentColor: GlyphColors.content,
                        ),
                      ),
                      Expanded(
                        child: _SummaryCard(
                          label: 'Outstanding',
                          value: r'$41,500',
                          detail: '5 open',
                          accentColor: GlyphColors.accentPrimary,
                        ),
                      ),
                      Expanded(
                        child: _SummaryCard(
                          label: 'Overdue',
                          value: r'$22,350',
                          detail: '3 past due',
                          accentColor: GlyphColors.feedbackError,
                        ),
                      ),
                      Expanded(
                        child: _SummaryCard(
                          label: 'Collected',
                          value: r'$27,000',
                          detail: '4 paid',
                          accentColor: GlyphColors.feedbackSuccess,
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
                        placeholder: 'Invoice number or client…',
                        onChanged: (_) => setState(() => _currentPage = 1),
                      ),
                    ),
                    GlyphDropdown<String>(
                      triggerStyle: GlyphDropdownTriggerStyle.stroke(),
                      items: const [
                        GlyphDropdownItem(value: 'All', label: 'All statuses'),
                        GlyphDropdownItem(value: 'Draft', label: 'Draft'),
                        GlyphDropdownItem(value: 'Sent', label: 'Sent'),
                        GlyphDropdownItem(value: 'Paid', label: 'Paid'),
                        GlyphDropdownItem(value: 'Overdue', label: 'Overdue'),
                      ],
                      value: _statusFilter,
                      onChanged: (v) =>
                          setState(() {
                            _statusFilter = v;
                            _currentPage = 1;
                          }),
                      placeholder: 'Status',
                      minWidth: 160,
                    ),
                  ],
                ),

                const SizedBox(height: Spacing.x4),

                // ── Table ─────────────────────────────────────────────────
                GlyphDataTable<_InvoiceRow>(
                  style: GlyphDataTableStyle.standard(),
                  columns: [
                    GlyphColumn<_InvoiceRow>(
                      header: 'Invoice',
                      fixedWidth: 160,
                      cell: (row) => Text(
                        row.number,
                        style: GlyphTextStyles.labelXsmall.copyWith(
                          color: GlyphColors.contentSubtle,
                        ),
                      ),
                    ),
                    GlyphColumn<_InvoiceRow>(
                      header: 'Client',
                      flex: 2,
                      cell: (row) => Text(
                        row.client,
                        style: GlyphTextStyles.paragraphSmall,
                      ),
                    ),
                    GlyphColumn<_InvoiceRow>(
                      header: 'Amount',
                      fixedWidth: 120,
                      cell: (row) => Text(
                        row.amount,
                        style: GlyphTextStyles.labelSmallStrong,
                      ),
                    ),
                    GlyphColumn<_InvoiceRow>(
                      header: 'Status',
                      fixedWidth: 110,
                      cell: (row) => GlyphBadge(
                        label: row.status,
                        style: _badgeForStatus(row.status),
                      ),
                    ),
                    GlyphColumn<_InvoiceRow>(
                      header: 'Issued',
                      fixedWidth: 120,
                      cell: (row) => Text(
                        row.issued,
                        style: GlyphTextStyles.labelXsmall.copyWith(
                          color: GlyphColors.contentSubtle,
                        ),
                      ),
                    ),
                    GlyphColumn<_InvoiceRow>(
                      header: 'Due',
                      fixedWidth: 120,
                      cell: (row) => Text(
                        row.due,
                        style: GlyphTextStyles.labelXsmall.copyWith(
                          color: row.status == 'Overdue'
                              ? GlyphColors.feedbackError
                              : GlyphColors.contentSubtle,
                        ),
                      ),
                    ),
                  ],
                  rows: _visibleRows,
                  footer: _totalFiltered > _itemsPerPage
                      ? GlyphPagination(
                          style: GlyphPaginationStyle.standard(),
                          currentPage: _currentPage,
                          totalItems: _totalFiltered,
                          itemsPerPage: _itemsPerPage,
                          onPrevious: _currentPage > 1
                              ? () => setState(() => _currentPage--)
                              : null,
                          onNext: _currentPage * _itemsPerPage < _totalFiltered
                              ? () => setState(() => _currentPage++)
                              : null,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Summary card ──────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.detail,
    required this.accentColor,
  });

  final String label;
  final String value;
  final String detail;
  final Color accentColor;

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
          Text(
            value,
            style: GlyphTextStyles.titleXsmall.copyWith(color: accentColor),
          ),
          const SizedBox(height: Spacing.x2),
          Text(
            detail,
            style: GlyphTextStyles.labelXsmall.copyWith(
              color: GlyphColors.contentDisabled,
            ),
          ),
        ],
      ),
    );
  }
}
