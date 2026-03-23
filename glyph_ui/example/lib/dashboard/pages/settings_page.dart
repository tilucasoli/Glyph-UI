import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';

// ── Section enum ──────────────────────────────────────────────────────────────

enum _Section {
  profile('Profile', Icons.person_outline),
  notifications('Notifications', Icons.notifications_none_outlined),
  security('Security', Icons.shield_outlined),
  billing('Plan & Billing', Icons.credit_card_outlined);

  const _Section(this.label, this.icon);
  final String label;
  final IconData icon;
}

// ── Page ──────────────────────────────────────────────────────────────────────

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _Section _section = _Section.profile;
  bool _hasUnsaved = false;

  // Profile
  final _companyNameController =
      TextEditingController(text: 'Ledger Financial Inc.');
  final _emailController =
      TextEditingController(text: 'billing@ledger.finance');
  final _websiteController =
      TextEditingController(text: 'https://ledger.finance');
  final _phoneController = TextEditingController(text: '+1 (415) 555-0192');
  final _addressLine1Controller =
      TextEditingController(text: '100 Market Street');
  final _addressLine2Controller =
      TextEditingController(text: 'San Francisco, CA 94105');

  // Notifications
  bool _notifInvoiceViewed = true;
  bool _notifPaymentReceived = true;
  bool _notifWeeklySummary = false;
  bool _notifOverdueReminders = true;
  bool _notifNewTeamMember = false;

  // Security
  bool _twoFactorEnabled = false;

  void _markUnsaved() => setState(() => _hasUnsaved = true);

  @override
  void initState() {
    super.initState();
    for (final c in [
      _companyNameController,
      _emailController,
      _websiteController,
      _phoneController,
      _addressLine1Controller,
      _addressLine2Controller,
    ]) {
      c.addListener(_markUnsaved);
    }
  }

  @override
  void dispose() {
    for (final c in [
      _companyNameController,
      _emailController,
      _websiteController,
      _phoneController,
      _addressLine1Controller,
      _addressLine2Controller,
    ]) {
      c.removeListener(_markUnsaved);
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── App bar ──────────────────────────────────────────────────────────
        GlyphAppBar(
          style: GlyphAppBarStyle.standard(),
          breadcrumbs: ['Account', 'Settings', _section.label],
          actions: [
            GlyphButton(
              label: 'Save changes',
              onPressed: _hasUnsaved
                  ? () => setState(() => _hasUnsaved = false)
                  : null,
              style: GlyphButtonStyle.filled(),
              metrics: GlyphButtonMetrics.medium(),
            ),
          ],
        ),

        // ── Body ─────────────────────────────────────────────────────────────
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left nav
              _SettingsNav(
                selected: _section,
                onSelect: (s) => setState(() => _section = s),
              ),
              // Content
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return switch (_section) {
      _Section.profile => _ProfilePanel(
          companyName: _companyNameController,
          email: _emailController,
          website: _websiteController,
          phone: _phoneController,
          addressLine1: _addressLine1Controller,
          addressLine2: _addressLine2Controller,
        ),
      _Section.notifications => _NotificationsPanel(
          invoiceViewed: _notifInvoiceViewed,
          paymentReceived: _notifPaymentReceived,
          weeklySummary: _notifWeeklySummary,
          overdueReminders: _notifOverdueReminders,
          newTeamMember: _notifNewTeamMember,
          onChanged: (field, v) => setState(() {
            _hasUnsaved = true;
            switch (field) {
              case 'invoiceViewed':
                _notifInvoiceViewed = v;
              case 'paymentReceived':
                _notifPaymentReceived = v;
              case 'weeklySummary':
                _notifWeeklySummary = v;
              case 'overdueReminders':
                _notifOverdueReminders = v;
              case 'newTeamMember':
                _notifNewTeamMember = v;
            }
          }),
        ),
      _Section.security => _SecurityPanel(
          twoFactorEnabled: _twoFactorEnabled,
          onTwoFactorChanged: (v) =>
              setState(() {
                _twoFactorEnabled = v;
                _hasUnsaved = true;
              }),
        ),
      _Section.billing => const _BillingPanel(),
    };
  }
}

// ── Left nav ──────────────────────────────────────────────────────────────────

class _SettingsNav extends StatelessWidget {
  const _SettingsNav({required this.selected, required this.onSelect});

  final _Section selected;
  final ValueChanged<_Section> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: GlyphColors.surface,
        border: Border(right: BorderSide(color: GlyphColors.border)),
      ),
      padding: const EdgeInsets.fromLTRB(
        Spacing.x4,
        Spacing.x5,
        Spacing.x4,
        Spacing.x5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: Spacing.x3,
              bottom: Spacing.x2,
            ),
            child: Text(
              'SETTINGS',
              style: GlyphTextStyles.label2Xsmall.copyWith(
                color: GlyphColors.contentDisabled,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ...(_Section.values.map(
            (s) => _NavItem(
              section: s,
              isSelected: s == selected,
              onTap: () => onSelect(s),
            ),
          )),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.section,
    required this.isSelected,
    required this.onTap,
  });

  final _Section section;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          margin: const EdgeInsets.only(bottom: Spacing.x1),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.x3,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? GlyphColors.accentSubtleContainer
                : Colors.transparent,
            borderRadius: GlyphRadius.borderMedium,
          ),
          child: Row(
            spacing: Spacing.x3,
            children: [
              Icon(
                section.icon,
                size: 16,
                color: isSelected
                    ? GlyphColors.accentPrimary
                    : GlyphColors.contentSubtle,
              ),
              Text(
                section.label,
                style: (isSelected
                        ? GlyphTextStyles.labelSmallStrong
                        : GlyphTextStyles.labelSmall)
                    .copyWith(
                  color: isSelected
                      ? GlyphColors.accentPrimary
                      : GlyphColors.contentSubtle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Shared layout primitives ──────────────────────────────────────────────────

class _PanelScroll extends StatelessWidget {
  const _PanelScroll({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Spacing.x8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: child,
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GlyphTextStyles.titleXsmall),
        const SizedBox(height: Spacing.x1),
        Text(
          subtitle,
          style: GlyphTextStyles.paragraphSmall.copyWith(
            color: GlyphColors.contentSubtle,
          ),
        ),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
    required this.label,
    required this.description,
    required this.trailing,
    this.isLast = false,
  });

  final String label;
  final String description;
  final Widget trailing;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.x4),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: GlyphTextStyles.labelSmallStrong),
                    const SizedBox(height: Spacing.x1),
                    Text(
                      description,
                      style: GlyphTextStyles.paragraphSmall.copyWith(
                        color: GlyphColors.contentSubtle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.x6),
              trailing,
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, thickness: 1, color: GlyphColors.border),
      ],
    );
  }
}

// ── Profile panel ─────────────────────────────────────────────────────────────

class _ProfilePanel extends StatelessWidget {
  const _ProfilePanel({
    required this.companyName,
    required this.email,
    required this.website,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
  });

  final TextEditingController companyName;
  final TextEditingController email;
  final TextEditingController website;
  final TextEditingController phone;
  final TextEditingController addressLine1;
  final TextEditingController addressLine2;

  @override
  Widget build(BuildContext context) {
    return _PanelScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(
            title: 'Company Profile',
            subtitle: 'Appears on invoices and outgoing communications.',
          ),

          const SizedBox(height: Spacing.x6),

          // Logo + company name row
          Row(
            spacing: Spacing.x5,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo placeholder
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: GlyphColors.accentSubtleContainer,
                  border: Border.fromBorderSide(
                    const BorderSide(color: GlyphColors.border),
                  ),
                  borderRadius: GlyphRadius.borderMedium,
                ),
                child: Center(
                  child: Text(
                    'LF',
                    style: GlyphTextStyles.labelSmallStrong.copyWith(
                      color: GlyphColors.accentPrimary,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Company logo',
                    style: GlyphTextStyles.labelSmallStrong,
                  ),
                  const SizedBox(height: Spacing.x1),
                  Text(
                    'PNG or SVG, max 512 KB.',
                    style: GlyphTextStyles.labelXsmall.copyWith(
                      color: GlyphColors.contentSubtle,
                    ),
                  ),
                  const SizedBox(height: Spacing.x2),
                  GlyphButton(
                    label: 'Upload logo',
                    onPressed: () {},
                    style: GlyphButtonStyle.stroke(),
                    metrics: GlyphButtonMetrics.small(),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: Spacing.x6),

          GlyphCard(
            style: GlyphCardStyle.surface(),
            metrics: GlyphCardMetrics.medium(),
            child: Column(
              spacing: Spacing.x4,
              children: [
                // Row 1: company name + billing email
                Row(
                  spacing: Spacing.x4,
                  children: [
                    Expanded(
                      child: GlyphTextField(
                        label: 'Company name',
                        style: GlyphTextFieldStyle.stroke(),
                        controller: companyName,
                      ),
                    ),
                    Expanded(
                      child: GlyphTextField(
                        label: 'Billing email',
                        style: GlyphTextFieldStyle.stroke(),
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                // Row 2: website + phone
                Row(
                  spacing: Spacing.x4,
                  children: [
                    Expanded(
                      child: GlyphTextField(
                        label: 'Website',
                        style: GlyphTextFieldStyle.stroke(),
                        controller: website,
                        keyboardType: TextInputType.url,
                      ),
                    ),
                    Expanded(
                      child: GlyphTextField(
                        label: 'Phone',
                        style: GlyphTextFieldStyle.stroke(),
                        controller: phone,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                // Row 3: address
                Row(
                  spacing: Spacing.x4,
                  children: [
                    Expanded(
                      child: GlyphTextField(
                        label: 'Street address',
                        style: GlyphTextFieldStyle.stroke(),
                        controller: addressLine1,
                      ),
                    ),
                    Expanded(
                      child: GlyphTextField(
                        label: 'City, state, postcode',
                        style: GlyphTextFieldStyle.stroke(),
                        controller: addressLine2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Notifications panel ───────────────────────────────────────────────────────

class _NotificationsPanel extends StatelessWidget {
  const _NotificationsPanel({
    required this.invoiceViewed,
    required this.paymentReceived,
    required this.weeklySummary,
    required this.overdueReminders,
    required this.newTeamMember,
    required this.onChanged,
  });

  final bool invoiceViewed;
  final bool paymentReceived;
  final bool weeklySummary;
  final bool overdueReminders;
  final bool newTeamMember;
  final void Function(String field, bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return _PanelScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(
            title: 'Notifications',
            subtitle: 'Email alerts sent to the billing address on file.',
          ),

          const SizedBox(height: Spacing.x6),

          _GroupLabel(label: 'INVOICE EVENTS'),
          const SizedBox(height: Spacing.x2),
          GlyphCard(
            style: GlyphCardStyle.surface(),
            metrics: GlyphCardMetrics.medium(),
            child: Column(
              children: [
                _RowItem(
                  label: 'Invoice viewed',
                  description: 'Triggered when a client opens an invoice link.',
                  trailing: _Toggle(
                    value: invoiceViewed,
                    onChanged: (v) => onChanged('invoiceViewed', v),
                  ),
                ),
                _RowItem(
                  label: 'Payment received',
                  description: 'A receipt is sent when a payment settles.',
                  trailing: _Toggle(
                    value: paymentReceived,
                    onChanged: (v) => onChanged('paymentReceived', v),
                  ),
                ),
                _RowItem(
                  label: 'Overdue reminders',
                  description:
                      'Automatic follow-ups at 3, 7, and 14 days overdue.',
                  trailing: _Toggle(
                    value: overdueReminders,
                    onChanged: (v) => onChanged('overdueReminders', v),
                  ),
                  isLast: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: Spacing.x5),

          _GroupLabel(label: 'ACCOUNT & TEAM'),
          const SizedBox(height: Spacing.x2),
          GlyphCard(
            style: GlyphCardStyle.surface(),
            metrics: GlyphCardMetrics.medium(),
            child: Column(
              children: [
                _RowItem(
                  label: 'Weekly summary',
                  description:
                      'Digest of revenue, invoices, and activity — Mondays.',
                  trailing: _Toggle(
                    value: weeklySummary,
                    onChanged: (v) => onChanged('weeklySummary', v),
                  ),
                ),
                _RowItem(
                  label: 'New team member',
                  description: 'Notify when someone joins the organisation.',
                  trailing: _Toggle(
                    value: newTeamMember,
                    onChanged: (v) => onChanged('newTeamMember', v),
                  ),
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Security panel ────────────────────────────────────────────────────────────

class _SecurityPanel extends StatelessWidget {
  const _SecurityPanel({
    required this.twoFactorEnabled,
    required this.onTwoFactorChanged,
  });

  final bool twoFactorEnabled;
  final ValueChanged<bool> onTwoFactorChanged;

  @override
  Widget build(BuildContext context) {
    return _PanelScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(
            title: 'Security',
            subtitle: 'Authentication settings and active session management.',
          ),

          const SizedBox(height: Spacing.x6),

          GlyphCard(
            style: GlyphCardStyle.surface(),
            metrics: GlyphCardMetrics.medium(),
            child: Column(
              children: [
                _RowItem(
                  label: 'Two-factor authentication',
                  description:
                      'Require a one-time code on every sign-in. Strongly recommended.',
                  trailing: _Toggle(
                    value: twoFactorEnabled,
                    onChanged: onTwoFactorChanged,
                  ),
                ),
                _RowItem(
                  label: 'Password',
                  description: 'Last changed 90 days ago.',
                  trailing: GlyphButton(
                    label: 'Change',
                    onPressed: () {},
                    style: GlyphButtonStyle.stroke(),
                    metrics: GlyphButtonMetrics.small(),
                  ),
                ),
                _RowItem(
                  label: 'Active sessions',
                  description: '2 devices currently signed in.',
                  trailing: GlyphButton(
                    label: 'Manage',
                    onPressed: () {},
                    style: GlyphButtonStyle.stroke(),
                    metrics: GlyphButtonMetrics.small(),
                  ),
                  isLast: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: Spacing.x8),

          // Danger zone — no card, just a flat bordered row
          const Divider(height: 1, thickness: 1, color: GlyphColors.border),
          const SizedBox(height: Spacing.x6),

          Text(
            'Danger zone',
            style: GlyphTextStyles.labelSmallStrong.copyWith(
              color: GlyphColors.feedbackError,
            ),
          ),
          const SizedBox(height: Spacing.x4),

          Container(
            padding: const EdgeInsets.all(Spacing.x5),
            decoration: BoxDecoration(
              color: GlyphColors.feedbackErrorContainer.withValues(alpha: 0.4),
              border: Border.fromBorderSide(
                const BorderSide(color: GlyphColors.feedbackErrorContainer),
              ),
              borderRadius: GlyphRadius.borderLarge,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delete organisation',
                        style: GlyphTextStyles.labelSmallStrong,
                      ),
                      const SizedBox(height: Spacing.x1),
                      Text(
                        'Permanently removes all data, invoices, and team members. Cannot be undone.',
                        style: GlyphTextStyles.paragraphSmall.copyWith(
                          color: GlyphColors.contentSubtle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Spacing.x6),
                GlyphButton(
                  label: 'Delete',
                  onPressed: () {},
                  style: GlyphButtonStyle.stroke().copyWith(
                    foregroundColor: const WidgetStatePropertyAll(
                      GlyphColors.feedbackError,
                    ),
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        side: BorderSide(
                          color: GlyphColors.feedbackErrorContainer,
                        ),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.hovered) ||
                          states.contains(WidgetState.pressed)) {
                        return GlyphColors.feedbackErrorContainer;
                      }
                      return GlyphColors.surface;
                    }),
                  ),
                  metrics: GlyphButtonMetrics.medium(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Billing panel ─────────────────────────────────────────────────────────────

class _BillingPanel extends StatelessWidget {
  const _BillingPanel();

  @override
  Widget build(BuildContext context) {
    return _PanelScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(
            title: 'Plan & Billing',
            subtitle: 'Manage your subscription and payment method.',
          ),

          const SizedBox(height: Spacing.x6),

          // Current plan
          GlyphCard(
            style: GlyphCardStyle.surface(),
            metrics: GlyphCardMetrics.medium(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: Spacing.x2,
                            children: [
                              Text(
                                'Business',
                                style: GlyphTextStyles.subtitleSmall,
                              ),
                              const GlyphBadge(
                                label: 'Active',
                                style: GlyphBadgeStyle.success(),
                              ),
                            ],
                          ),
                          const SizedBox(height: Spacing.x1),
                          Text(
                            r'$149 / month · renews 1 Apr 2026',
                            style: GlyphTextStyles.paragraphSmall.copyWith(
                              color: GlyphColors.contentSubtle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GlyphButton(
                      label: 'Manage plan',
                      onPressed: () {},
                      style: GlyphButtonStyle.stroke(),
                      metrics: GlyphButtonMetrics.medium(),
                    ),
                  ],
                ),

                const SizedBox(height: Spacing.x5),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: GlyphColors.border,
                ),
                const SizedBox(height: Spacing.x5),

                // Usage meters
                _GroupLabel(label: 'USAGE THIS PERIOD'),
                const SizedBox(height: Spacing.x4),
                Row(
                  spacing: Spacing.x6,
                  children: const [
                    Expanded(
                      child: _UsageStat(
                        label: 'Invoices sent',
                        value: '42',
                        limit: 'of unlimited',
                      ),
                    ),
                    Expanded(
                      child: _UsageStat(
                        label: 'Team members',
                        value: '4',
                        limit: 'of 10 seats',
                      ),
                    ),
                    Expanded(
                      child: _UsageStat(
                        label: 'File storage',
                        value: '1.2 GB',
                        limit: 'of 10 GB',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: Spacing.x5),

          _GroupLabel(label: 'PAYMENT METHOD'),
          const SizedBox(height: Spacing.x2),
          GlyphCard(
            style: GlyphCardStyle.surface(),
            metrics: GlyphCardMetrics.medium(),
            child: _RowItem(
              label: 'Visa ending in 4242',
              description: 'Expires 09 / 2028',
              trailing: GlyphButton(
                label: 'Update card',
                onPressed: () {},
                style: GlyphButtonStyle.stroke(),
                metrics: GlyphButtonMetrics.medium(),
              ),
              isLast: true,
            ),
          ),

          const SizedBox(height: Spacing.x5),

          _GroupLabel(label: 'BILLING HISTORY'),
          const SizedBox(height: Spacing.x2),
          GlyphCard(
            style: GlyphCardStyle.surface(),
            metrics: GlyphCardMetrics.medium(),
            child: Column(
              children: [
                _BillingHistoryRow(
                  date: '1 Mar 2026',
                  amount: r'$149.00',
                  status: 'Paid',
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: GlyphColors.border,
                ),
                _BillingHistoryRow(
                  date: '1 Feb 2026',
                  amount: r'$149.00',
                  status: 'Paid',
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: GlyphColors.border,
                ),
                _BillingHistoryRow(
                  date: '1 Jan 2026',
                  amount: r'$149.00',
                  status: 'Paid',
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Small helpers ─────────────────────────────────────────────────────────────

class _GroupLabel extends StatelessWidget {
  const _GroupLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GlyphTextStyles.label2Xsmall.copyWith(
        color: GlyphColors.contentDisabled,
        letterSpacing: 0.6,
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  const _Toggle({required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: GlyphColors.surface,
      activeTrackColor: GlyphColors.accentPrimary,
    );
  }
}

class _UsageStat extends StatelessWidget {
  const _UsageStat({
    required this.label,
    required this.value,
    required this.limit,
  });

  final String label;
  final String value;
  final String limit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GlyphTextStyles.labelXsmall.copyWith(
            color: GlyphColors.contentSubtle,
          ),
        ),
        const SizedBox(height: Spacing.x1),
        Text(value, style: GlyphTextStyles.labelSmallStrong),
        const SizedBox(height: 2),
        Text(
          limit,
          style: GlyphTextStyles.labelXsmall.copyWith(
            color: GlyphColors.contentDisabled,
          ),
        ),
      ],
    );
  }
}

class _BillingHistoryRow extends StatelessWidget {
  const _BillingHistoryRow({
    required this.date,
    required this.amount,
    required this.status,
    this.isLast = false,
  });

  final String date;
  final String amount;
  final String status;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Spacing.x3,
        bottom: isLast ? 0 : Spacing.x3,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              date,
              style: GlyphTextStyles.paragraphSmall,
            ),
          ),
          Text(
            amount,
            style: GlyphTextStyles.labelSmallStrong,
          ),
          const SizedBox(width: Spacing.x4),
          const GlyphBadge(
            label: 'Paid',
            style: GlyphBadgeStyle.success(),
          ),
          const SizedBox(width: Spacing.x3),
          GlyphButton(
            label: 'Receipt',
            onPressed: () {},
            style: GlyphButtonStyle.ghost(),
            metrics: GlyphButtonMetrics.small(),
          ),
        ],
      ),
    );
  }
}
