import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigationScreen(),
    ),
  );
}

// هذا الكود هو المتحكم الرئيسي في التنقل بين الصفحات
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedNavIndex = 0; // الصفحة الحالية
  int? pressedNavIndex;

  // قائمة الصفحات
  final List<Widget> _pages = [
    const HealthDashboard(), // صفحة الرئسية (index 0)
    const Center(child: Text("صفحة التحليل")), // صفحة مؤقتة (index 1)
    const ProfilePage(), // صفحة الملف الشخصي (index 2)
    const Center(child: Text("صفحة الإعدادات")), // صفحة مؤقتة (index 3)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: _pages[selectedNavIndex], // عرض الصفحة المختارة
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFAB(),
    );
  }

  // بناء القائمة السفلية مع التفاعل
  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavIcon(0, Icons.home_filled, "الرئيسية"),
            _buildNavIcon(1, Icons.bar_chart_rounded, "تحليل"),
            const SizedBox(width: 40),
            _buildNavIcon(2, Icons.person_outline_rounded, "ملفي"),
            _buildNavIcon(3, Icons.settings_outlined, "الإعدادات"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(int index, IconData icon, String label) {
    bool isPressed = pressedNavIndex == index;
    bool isActive = selectedNavIndex == index;

    return GestureDetector(
      onTapDown: (_) => setState(() => pressedNavIndex = index),
      onTapUp: (_) => setState(() {
        pressedNavIndex = null;
        selectedNavIndex = index; // الانتقال للصفحة
      }),
      onTapCancel: () => setState(() => pressedNavIndex = null),
      child: AnimatedScale(
        scale: isPressed ? 1.3 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.teal : Colors.grey.shade400,
              size: 26,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? Colors.teal : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.teal.shade300,
      child: const Icon(Icons.add, size: 30, color: Colors.white),
    );
  }
}

// --- صفحة الملف الشخصي (تصميم الصورة الثانية) ---
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(Icons.qr_code_scanner, color: Colors.black),
          title: const Text(
            "الملف الشخصي",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: const [
            Icon(Icons.settings, color: Colors.black),
            SizedBox(width: 15),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 20),
            // صورة البروفايل
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                "أحمد عبدالله العتيبي",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                "رقم الهوية: ١٠٩٨٧٦٥٤٣٢",
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
            ),

            const SizedBox(height: 30),

            // المعلومات الشخصية (الوزن، الطول، العمر)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCard("الوزن", "٧٥ كجم"),
                _buildInfoCard("الطول", "١٧٨ سم"),
                _buildInfoCard("العمر", "٣٤ سنة"),
              ],
            ),

            const SizedBox(height: 25),

            // السجل الطبي
            _buildSectionTitle(Icons.medical_services, "السجل الطبي"),
            _buildListTile("نوع السكري", "النوع الثاني"),
            _buildListTile("فصيلة الدم", "+O"),
            _buildListTile("تاريخ آخر فحص", "١٢ أكتوبر ٢٠٢٣"),

            const SizedBox(height: 20),

            // إعدادات الحساب
            _buildSectionTitle(Icons.settings_suggest, "إعدادات الحساب"),
            _buildListTileWithIcon(Icons.notifications_none, "التنبيهات"),
            _buildListTileWithIcon(
              Icons.language,
              "اللغة",
              trailingText: "العربية",
            ),
            const ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("تسجيل الخروج", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildListTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildListTileWithIcon(
    IconData icon,
    String title, {
    String? trailingText,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(trailingText, style: const TextStyle(color: Colors.grey)),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}

// --- صفحة الرئسية (استخدم كودك القديم هنا) ---
class HealthDashboard extends StatelessWidget {
  const HealthDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("هنا تضع محتوى الصفحة الرئيسية"));
  }
}
