import 'package:flutter/material.dart';

const double kWideBreakpoint = 600;

void main() => runApp(const AcademicOverviewApp());

extension ThemeSpacing on ThemeData {
  double get spacingXS => 4;
  double get spacingSM => 8;
  double get spacingMD => 12;
  double get spacingLG => 16;
  double get spacingXL => 20;
  double get spacing2XL => 24;
  
  double get radiusSM => 8;
  double get radiusMD => 12;
  double get radiusLG => 16;
  
  double get iconSizeSM => 20;
  double get iconSizeMD => 24;
  double get iconSizeLG => 28;
  double get iconSizeXL => 40;
  
  double get avatarRadius => 36;
}

extension CardPadding on ThemeData {
  EdgeInsets get cardPadding => EdgeInsets.all(spacingXL);
  EdgeInsets get iconButtonPadding => EdgeInsets.all(spacingMD);
}

class AcademicOverviewApp extends StatefulWidget {
  const AcademicOverviewApp({super.key});

  @override
  State<AcademicOverviewApp> createState() => _AcademicOverviewAppState();
}

class _AcademicOverviewAppState extends State<AcademicOverviewApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: AcademicOverviewPage(
        isDark: isDark,
        onDarkChanged: (value) => setState(() => isDark = value),
      ),
    );
  }
}

class AcademicOverviewPage extends StatelessWidget {
  const AcademicOverviewPage({
    required this.isDark,
    required this.onDarkChanged,
    super.key,
  });

  final bool isDark;
  final ValueChanged<bool> onDarkChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Overview'),
        actions: [
          Semantics(
            label: 'Toggle theme. Currently ${isDark ? "dark" : "light"} mode.',
            child: Row(
              children: [
                Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                SizedBox(width: theme.spacingSM),
                Switch.adaptive(value: isDark, onChanged: onDarkChanged),
                SizedBox(width: theme.spacingLG),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            SizedBox(height: theme.spacing2XL),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= kWideBreakpoint;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isWide ? 2 : 1,
                  crossAxisSpacing: theme.spacingLG,
                  mainAxisSpacing: theme.spacingLG,
                  childAspectRatio: isWide ? 2.5 : 2.8,
                  children: const [
                    InfoCard(
                      title: 'GPA',
                      value: '3.75 / 4.00',
                      icon: Icons.school,
                      semanticLabel: 'GPA: 3.75 out of 4.0',
                      colorType: InfoCardColor.primary,
                    ),
                    InfoCard(
                      title: 'Credits',
                      value: '96 / 144 SKS',
                      icon: Icons.workspace_premium,
                      semanticLabel: 'Credits: 96 out of 144 completed',
                      colorType: InfoCardColor.secondary,
                    ),
                    InfoCard(
                      title: 'Today Schedule',
                      value: '3 Classes',
                      icon: Icons.schedule,
                      semanticLabel: 'Today schedule: 3 classes. Mobile Programming at 08:00, Database Systems at 10:00, Software Engineering at 13:00',
                      colorType: InfoCardColor.tertiary,
                    ),
                    InfoCard(
                      title: 'Announcements',
                      value: '5 Unread',
                      icon: Icons.notifications_active,
                      semanticLabel: '5 unread announcements',
                      colorType: InfoCardColor.error,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(theme.spacingXL),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(theme.radiusLG),
      ),
      child: Row(
        children: [
          Semantics(
            label: 'Profile picture',
            child: CircleAvatar(
              radius: theme.avatarRadius,
              backgroundColor: theme.colorScheme.primary,
              child: Icon(
                Icons.person,
                size: theme.iconSizeXL,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          SizedBox(width: theme.spacingLG),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tegar Prianiatama',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: theme.spacingXS),
                Text('NIM: 20210101001', style: theme.textTheme.bodyMedium),
                Text(
                  'Teknik Informatika',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.semanticLabel,
    this.colorType = InfoCardColor.primary,
    super.key,
  });

  final String title;
  final String value;
  final IconData icon;
  final String semanticLabel;
  final InfoCardColor colorType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _getColors(theme);

    return Semantics(
      label: semanticLabel,
      child: Card(
        child: Padding(
          padding: theme.cardPadding,
          child: Row(
            children: [
              Container(
                padding: theme.iconButtonPadding,
                decoration: BoxDecoration(
                  color: colors.containerColor,
                  borderRadius: BorderRadius.circular(theme.radiusMD),
                ),
                child: Icon(
                  icon,
                  color: colors.iconColor,
                  size: theme.iconSizeLG,
                ),
              ),
              SizedBox(width: theme.spacingLG),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    Text(
                      value,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _CardColors _getColors(ThemeData theme) {
    switch (colorType) {
      case InfoCardColor.primary:
        return _CardColors(
          containerColor: theme.colorScheme.primaryContainer,
          iconColor: theme.colorScheme.primary,
          textColor: theme.colorScheme.primary,
        );
      case InfoCardColor.secondary:
        return _CardColors(
          containerColor: theme.colorScheme.secondaryContainer,
          iconColor: theme.colorScheme.secondary,
          textColor: theme.colorScheme.secondary,
        );
      case InfoCardColor.tertiary:
        return _CardColors(
          containerColor: theme.colorScheme.tertiaryContainer,
          iconColor: theme.colorScheme.tertiary,
          textColor: theme.colorScheme.tertiary,
        );
      case InfoCardColor.error:
        return _CardColors(
          containerColor: theme.colorScheme.errorContainer,
          iconColor: theme.colorScheme.error,
          textColor: theme.colorScheme.error,
        );
    }
  }
}

enum InfoCardColor { primary, secondary, tertiary, error }

class _CardColors {
  const _CardColors({
    required this.containerColor,
    required this.iconColor,
    required this.textColor,
  });

  final Color containerColor;
  final Color iconColor;
  final Color textColor;
}
