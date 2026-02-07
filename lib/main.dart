import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'profilepage.dart';
import 'medications_page.dart';
import 'health_dashboard.dart';
import 'blood_sugar_logs_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigationScreen(),
    ),
  );
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedNavIndex = 0;
  int? pressedNavIndex;

  final List<Widget> _pages = [
    const HealthDashboard(),
    const Center(child: Text("صفحة التحليل")),
    const ProfilePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: _pages[selectedNavIndex],
      bottomNavigationBar: _buildAnimatedBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildAnimatedFAB(),
    );
  }

  Widget _buildAnimatedBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavIcon(0, Icons.home_filled),
            _buildNavIcon(1, Icons.bar_chart_rounded),
            const SizedBox(width: 40),
            _buildNavIcon(2, Icons.person_outline_rounded),
            _buildNavIcon(3, Icons.settings_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(int index, IconData icon) {
    bool isPressed = pressedNavIndex == index;
    bool isActive = selectedNavIndex == index;

    return GestureDetector(
      onTapDown: (_) => setState(() => pressedNavIndex = index),
      onTapUp: (_) => setState(() {
        pressedNavIndex = null;
        selectedNavIndex = index;
      }),
      onTapCancel: () => setState(() => pressedNavIndex = null),
      child: AnimatedScale(
        scale: isPressed ? 1.3 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Icon(
          icon,
          size: 28,
          color: isActive ? Colors.teal : Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildAnimatedFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.teal.shade300,
      elevation: 4,
      child: const Icon(Icons.add, size: 30, color: Colors.white),
    );
  }
}

class HealthDashboard extends StatefulWidget {
  const HealthDashboard({super.key});
  @override
  State<HealthDashboard> createState() => _HealthDashboardState();
}

class _HealthDashboardState extends State<HealthDashboard> {
  int? selectedServiceIndex;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildHeader(),
            const SizedBox(height: 25),
            const Text(
              "صباح الخير ☀️",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text(
              "آخر تحديث: 08:47 ص",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 25),
            _buildMainStatusCard(),
            const SizedBox(height: 30),
            const Text(
              "الخدمات الصحية",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.0,
              children: [
                _buildServiceCard(
                  0,
                  "وجباتي",
                  "النظام الغذائي",
                  Icons.restaurant,
                  Colors.teal,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainHealthScreen(),
                    ),
                  ),
                ),
                _buildServiceCard(
                  1,
                  "علاجاتي",
                  "الأدوية والجرعات",
                  Icons.assignment,
                  Colors.blue,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MedicationsPage(),
                    ),
                  ),
                ),
                _buildServiceCard(
                  2,
                  "قراءاتي",
                  "سجل السكر اليومي",
                  Icons.show_chart,
                  Colors.orange,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BloodSugarLogsScreen(),
                    ),
                  ),
                ),
                _buildServiceCard(
                  3,
                  "تواصل مع الطبيب",
                  "استشارة طبية",
                  Icons.face,
                  Colors.purple,
                ),
                _buildServiceCard(
                  4,
                  "تقاريري",
                  "عرض السجلات",
                  Icons.description,
                  Colors.indigo,
                ),
                _buildServiceCard(
                  5,
                  "أنشطتي",
                  "التمارين البدنية",
                  Icons.directions_run,
                  Colors.amber,
                ),
              ],
            ),
            const SizedBox(height: 25),
            _buildDailyAdvice(), // إضافة نصيحة اليوم
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: const Icon(Icons.notifications_none, color: Colors.black54),
        ),
        Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "مرحباً بك،",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "أحمد بن سلمان",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.teal),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainStatusCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Colors.green,
                  size: 25,
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "حالة الجلوكوز",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    "مستقر",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatDetail("آخر قراءة", "108", "ملغ/ديسل"),
              _buildStatDetail("الوقت", "08:45", "ص"),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bar_chart, color: Colors.teal, size: 18),
                SizedBox(width: 8),
                Text(
                  "عرض المخطط البياني",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDetail(String label, String value, String unit) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildServiceCard(
    int index,
    String title,
    String subtitle,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    bool isPressed = selectedServiceIndex == index;
    return GestureDetector(
      onTapDown: (_) => setState(() => selectedServiceIndex = index),
      onTapUp: (_) => setState(() => selectedServiceIndex = null),
      onTapCancel: () => setState(() => selectedServiceIndex = null),
      onTap: onTap,
      child: AnimatedScale(
        scale: isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyAdvice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.shade50.withOpacity(0.4),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.teal.shade400, size: 30),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "نصيحة اليوم",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                Text(
                  "الانتظام في تسجيل وجباتك اليومية يساعد فريقك الطبي في تقديم أفضل رعاية لك.",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
