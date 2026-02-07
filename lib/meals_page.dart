import 'package:flutter/material.dart';

// --- 1. شاشة وجباتي (عرض القائمة) ---
class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "وجباتي",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(20),
              children: [_buildSummaryCard(), const SizedBox(height: 100)],
            ),
            Positioned(
              bottom: 70,
              left: 20,
              right: 20,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMealScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF34E073),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "إضافة وجبة",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() => Container(); // يمكنك إضافة محتواك هنا
}

// --- 2. شاشة إضافة وجبة (التصميم المطابق للصورة) ---
class AddMealScreen extends StatelessWidget {
  const AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Column(
              children: [
                // الجزء العلوي: الكاميرا
                _buildCameraTopSection(context),
                // الجزء السفلي: البحث والقائمة
                Expanded(child: _buildFoodSelectionList()),
              ],
            ),
            // زر الإدخال اليدوي العائم
            _buildManualEntryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraTopSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=500',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // طبقة تظليل
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.black.withOpacity(0.4),
        ),
        // أزرار التحكم العلوية
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleIcon(Icons.help_outline),
                const Text(
                  "إضافة وجبة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: _buildCircleIcon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ),
        // إطار الماسح الضوئي
        Positioned.fill(
          child: Center(
            child: Container(
              width: 260,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF34E073), width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Container(
                  height: 2,
                  width: 220,
                  color: const Color(0xFF34E073),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFoodSelectionList() {
    return Container(
      transform: Matrix4.translationValues(0, -25, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        children: [
          _buildSearchField(),
          const SizedBox(height: 25),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "أضيفت مؤخراً",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "عرض الكل",
                style: TextStyle(
                  color: Color(0xFF34E073),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // _buildFoodCard(
          //   "خبز بر",
          //   "20 غرام كربوهيدرات • 80 سعرة",
          //   "https://tse2.mm.bing.net/th/id/OIP.JWZYO8CmG61J4fTBiyq-zQHaEU?rs=1&pid=ImgDetMain&o=7&rm=3",
          // ),
          // _buildFoodCard(
          //   "حليب كامل الدسم",
          //   "12 غرام كربوهيدرات • 150 سعرة",
          //   "https://images.unsplash.com/photo-1550583726-264880b3074d?w=100",
          // ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFoodCard(String name, String info, String img) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(img, width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  info,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFE8F5E9),
            child: Icon(Icons.add, color: Color(0xFF34E073)),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "بحث عن طعام...",
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon) => CircleAvatar(
    backgroundColor: Colors.white.withOpacity(0.2),
    child: Icon(icon, color: Colors.white, size: 20),
  );

  Widget _buildManualEntryButton() {
    return Positioned(
      bottom: 25,
      left: 20,
      right: 20,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF34E073),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text(
          "إدخال يدوي",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
