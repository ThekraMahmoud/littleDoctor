import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "إعدادات التطبيق",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            _buildSectionHeader("إعدادات الحساب"),
            _buildSettingCard([
              _buildTile(
                Icons.email_outlined,
                "البريد الإلكتروني",
                subtitle: "ahmed.diab@email.com",
              ),
              _buildTile(Icons.lock_outline, "كلمة المرور"),
              _buildTile(Icons.shield_outlined, "الأمان"),
            ]),

            _buildSectionHeader("تفضيلات التنبيهات"),
            _buildSettingCard([
              _buildSwitchTile(
                Icons.medical_services_outlined,
                "تذكير الدواء",
                true,
              ),
              _buildSwitchTile(
                Icons.calendar_today_outlined,
                "تنبيهات المواعيد",
                true,
              ),
            ]),

            _buildSectionHeader("تفضيلات التطبيق"),
            _buildSettingCard([
              _buildTile(
                Icons.language,
                "اللغة المختارة",
                trailingText: "العربية",
              ),
              _buildTile(
                Icons.dark_mode_outlined,
                "المظهر",
                trailingText: "وضع النهار",
              ),
            ]),

            _buildSectionHeader("المعلومات والدعم"),
            _buildSettingCard([
              _buildTile(Icons.info_outline, "عن التطبيق"),
              _buildTile(Icons.privacy_tip_outlined, "سياسة الخصوصية"),
            ]),

            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                "تسجيل الخروج",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.05),
                padding: const EdgeInsets.all(15),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSettingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTile(
    IconData icon,
    String title, {
    String? subtitle,
    String? trailingText,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.green, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 12))
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText,
              style: const TextStyle(color: Colors.green, fontSize: 13),
            ),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.green, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: Switch(
        value: value,
        onChanged: (v) {},
        activeColor: Colors.green,
      ),
    );
  }
}
