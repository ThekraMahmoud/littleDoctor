import 'package:flutter/material.dart';
import 'reading_details_screen.dart'; // تأكد أن هذا الملف موجود في مشروعك

class BloodSugarLogsScreen extends StatelessWidget {
  const BloodSugarLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.calendar_today, color: Colors.black),
        title: const Center(
          child: Text(
            "سجل قراءاتي",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // مررنا الـ context هنا لكي يعمل الزر بالداخل
            _buildLatestReadingCard(context),
            const SizedBox(height: 24),

            _buildReportSection(),
            const SizedBox(height: 24),

            const Text(
              "السجل الزمني",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildLogItem(
              "105",
              "بعد الإفطار • 10:30 صباحاً",
              Icons.restaurant,
              Colors.green,
            ),
            _buildLogItem(
              "142",
              "قبل الإفطار • 07:15 صباحاً",
              Icons.wb_sunny,
              Colors.orange,
            ),
            _buildLogItem(
              "98",
              "قبل النوم • أمس",
              Icons.nightlight_round,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  // أضفنا (BuildContext context) هنا لتمكين التنقل
  Widget _buildLatestReadingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "طبيعي",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const Text(
                "آخر قراءة مسجلة",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text("mg/dL", style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(width: 8),
              Text(
                "105",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Text(
            "منذ ساعتين (10:30 صباحاً)",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReadingDetailsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add_circle),
            label: const Text("إضافة قراءة جديدة"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2ECC71),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportSection() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("المتوسط: 112", style: TextStyle(color: Colors.green)),
            Text(
              "تقرير الـ 7 أيام الماضية",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(child: Text("الرسم البياني يوضع هنا")),
        ),
      ],
    );
  }

  Widget _buildLogItem(String value, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border(right: BorderSide(color: color, width: 5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.more_vert, color: Colors.grey),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "mg/dL $value",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(width: 15),
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 20),
          ),
        ],
      ),
    );
  }
}
