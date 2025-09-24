import 'package:accomodation_admin/features/superAdmin/home_screens/widgets/custom_drawer.dart';
import 'package:accomodation_admin/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

// A centralized place for our app's colors for consistency and easy theming.
class AppColors {
  static const Color primary = Color(0xFF0D47A1); // Deep Blue
  static const Color secondary = Color(0xFF1976D2); // Lighter Blue
  static const Color accent = Color(0xFF4CAF50); // Green for positive stats
  static const Color primaryText = Color(0xFF212121); // Dark grey for text
  static const Color secondaryText = Color(0xFF757575); // Lighter grey
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;

  // Chart Colors
  static const Color upiColor = Color(0xFF673AB7); // Deep Purple
  static const Color cardColor = Color(0xFF2196F3); // Blue
  static const Color cashColor = Color(0xFFF44336); // Red
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State for interactive chart
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktop = constraints.maxWidth > 1100;
          final bool isTablet =
              constraints.maxWidth > 600 && constraints.maxWidth <= 1100;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drawer is permanently visible on larger screens
              if (isDesktop || isTablet)
                Container(
                  width: isDesktop ? 250 : 200,
                  color: AppColors.cardBackground,
                  child: CustomDrawer(onItemTapped: (page) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Navigating to $page"),
                      duration: const Duration(seconds: 1),
                    ));
                  }),
                ),

              // Main Content Area
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildStatsGrid(), // <-- THIS IS THE MODIFIED WIDGET
                      const SizedBox(height: 24),
                      _buildMainContent(isDesktop, isTablet),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Main content layout that adapts to screen size
  Widget _buildMainContent(bool isDesktop, bool isTablet) {
    if (isDesktop) {
      // Desktop: Side-by-side layout
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildGraphCard(context),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildPaymentBreakdownCard(context),
                const SizedBox(height: 24),
                _buildRecentActivityCard(context),
              ],
            ),
          ),
        ],
      );
    } else {
      // Mobile & Tablet: Stacked layout
      return Column(
        children: [
          _buildGraphCard(context),
          const SizedBox(height: 24),
          _buildPaymentBreakdownCard(context),
          const SizedBox(height: 24),
          _buildRecentActivityCard(context),
        ],
      );
    }
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dashboard Overview',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Welcome back, Super Admin! Here is your performance summary.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.secondaryText,
              ),
        ),
      ],
    );
  }

  /// NEW: Uses a responsive GridView for the stats cards.
  /// This provides a more structured layout than Wrap, adapting the
  /// number of columns based on the available screen width.
  Widget _buildStatsGrid() {
    // Data for the stat cards. In a real app, this would come from a view model or state management.
    final List<Map<String, dynamic>> statsData = [
      {
        'title': 'Total Revenue',
        'value': '\$12,450',
        'icon': Icons.monetization_on,
        'color': AppColors.accent,
      },
      {
        'title': 'Bookings',
        'value': '281',
        'icon': Icons.calendar_today,
        'color': AppColors.secondary,
      },
      {
        'title': 'Occupancy Rate',
        'value': '85.2%',
        'icon': Icons.hotel,
        'color': Colors.orange,
      },
      {
        'title': 'New Guests',
        'value': '34',
        'icon': Icons.person_add,
        'color': Colors.purple,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // Determine column count based on width
        int crossAxisCount = 4;
        if (width < 1000) crossAxisCount = 2;
        if (width < 600) crossAxisCount = 1;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: crossAxisCount == 1
                ? 2.5
                : 1.7, // Taller cards in single column
          ),
          itemCount: statsData.length,
          shrinkWrap: true, // Needed for GridView inside SingleChildScrollView
          physics:
              const NeverScrollableScrollPhysics(), // Disable grid's scrolling
          itemBuilder: (context, index) {
            final stat = statsData[index];
            return _buildStatCard(
              stat['title'],
              stat['value'],
              stat['icon'],
              stat['color'],
            );
          },
        );
      },
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: AppColors.secondaryText, fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraphCard(BuildContext context) {
    final List<FlSpot> spots = [
      const FlSpot(0, 4.2),
      const FlSpot(1, 6.1),
      const FlSpot(2, 5.5),
      const FlSpot(3, 8.2),
      const FlSpot(4, 7.5),
      const FlSpot(5, 9.8),
    ];
    final List<String> months = ['Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Revenue',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Performance over the last 6 months (in \$1000s)',
              style: TextStyle(color: AppColors.secondaryText),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: AppColors.secondaryText.withOpacity(0.1),
                      strokeWidth: 1,
                    ),
                    getDrawingVerticalLine: (value) => FlLine(
                      color: AppColors.secondaryText.withOpacity(0.1),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(months[value.toInt()],
                                style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 12)),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() == 0 || value.toInt() % 2 != 0)
                            return const SizedBox();
                          return Text(
                            '\$${value.toInt()}k',
                            style: const TextStyle(
                                color: AppColors.secondaryText, fontSize: 12),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                        color: AppColors.secondaryText.withOpacity(0.1)),
                  ),
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 12,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      gradient: const LinearGradient(
                        colors: [AppColors.secondary, AppColors.primary],
                      ),
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.secondary.withOpacity(0.3),
                            AppColors.primary.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentBreakdownCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Methods',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Legend
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Indicator(
                        color: AppColors.cardColor,
                        text: 'Card',
                        isSquare: false),
                    SizedBox(height: 8),
                    Indicator(
                        color: AppColors.upiColor,
                        text: 'UPI',
                        isSquare: false),
                    SizedBox(height: 8),
                    Indicator(
                        color: AppColors.cashColor,
                        text: 'Cash',
                        isSquare: false),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0: // Card
          return PieChartSectionData(
            color: AppColors.cardColor,
            value: 45,
            title: '45%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows),
          );
        case 1: // UPI
          return PieChartSectionData(
            color: AppColors.upiColor,
            value: 35,
            title: '35%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows),
          );
        case 2: // Cash
          return PieChartSectionData(
            color: AppColors.cashColor,
            value: 20,
            title: '20%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows),
          );
        default:
          throw Error();
      }
    });
  }

  Widget _buildRecentActivityCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
            ),
            const SizedBox(height: 20),
            _buildActivityItem(Icons.login, 'New login from India',
                '10 min ago', AppColors.primary),
            _buildActivityItem(Icons.person_add,
                'New admin "Jane Smith" created', '1 hour ago', Colors.green),
            _buildActivityItem(Icons.report, 'Weekly report generated',
                'Yesterday', Colors.orange),
            _buildActivityItem(Icons.logout, 'Admin "John Doe" logged out',
                'Yesterday', Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
      IconData icon, String title, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText)),
                Text(time,
                    style: const TextStyle(
                        color: AppColors.secondaryText, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for the Pie Chart legend
class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = AppColors.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
