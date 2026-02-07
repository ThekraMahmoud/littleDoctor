import 'package:flutter/material.dart';
// تأكد من إضافة الملف الخاص بصفحة الوجبات هنا لاحقاً
// import 'meals_page.dart';

class MedicationsPage extends StatelessWidget {
  const MedicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          title: const Text(
            "علاجاتي",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.person, color: Colors.black54),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildDaysCalendar(),
            const SizedBox(height: 25),
            _buildProgressCard(),
            const SizedBox(height: 25),
            const Text(
              "الأدوية المجدولة",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildMedicationTile(
              "أنسولين غلارجين",
              "20 وحدة • 08:00 صباحاً",
              Icons.colorize,
              Colors.teal.shade100,
              Colors.teal,
            ),
            _buildMedicationTile(
              "ميتفورمين",
              "500 ملغ • 12:30 مساءً",
              Icons.medication,
              Colors.orange.shade100,
              Colors.orange,
            ),
            _buildMedicationTile(
              "فيتامين د",
              "جرعة واحدة • 02:00 مساءً",
              Icons.medication_liquid,
              Colors.blue.shade100,
              Colors.blue,
            ),
            const SizedBox(height: 20),
            _buildExpansionTile("تم التناول"),
            const SizedBox(height: 20),

            // تم تمرير context هنا لتمكين التنقل
            _buildAdviceCard(context),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // --- دالة نصيحة اليوم المحدثة للضغط ---
  Widget _buildAdviceCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // عند الضغط، سينتقل لصفحة وجباتي
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const MealsPage()));

        // رسالة تنبيه مؤقتة حتى تنشئ صفحة الوجبات
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("جاري الانتقال إلى صفحة وجباتي..."),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.teal,
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=500",
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // أيقونة توضح أن البطاقة قابلة للتفاعل
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.restaurant_menu,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "نصيحة اليوم الغذائية",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "تجنب السكريات المضافة في وجبة الإفطار للحفاظ على استقرار مستوى الغلوكوز. اضغط لعرض الوجبات المقترحة.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- بقية الدوال المساعدة كما هي ---
  Widget _buildDaysCalendar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _dayItem("السبت", "12", false),
        _dayItem("الأحد", "13", true),
        _dayItem("الاثنين", "14", false),
        _dayItem("الثلاثاء", "15", false),
        _dayItem("الأربعاء", "16", false),
      ],
    );
  }

  Widget _dayItem(String day, String date, bool isSelected) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF00E676) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            date,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "إنجاز اليوم",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "3 من 5 أدوية",
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: 0.6,
            backgroundColor: Colors.white,
            color: const Color(0xFF00E676),
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationTile(
    String name,
    String time,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: iconColor),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(String title) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        children: [
          _buildMedicationTile(
            "أسبرين",
            "81 ملغ • 07:00 صباحاً",
            Icons.check_circle,
            Colors.grey.shade100,
            Colors.grey,
          ),
        ],
      ),
    );
  }
}
