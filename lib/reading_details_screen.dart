import 'package:flutter/material.dart';

class ReadingDetailsScreen extends StatefulWidget {
  const ReadingDetailsScreen({super.key});

  @override
  State<ReadingDetailsScreen> createState() => _ReadingDetailsScreenState();
}

class _ReadingDetailsScreenState extends State<ReadingDetailsScreen> {
  // وحدة تحكم لتعديل قيمة السكر
  final TextEditingController _sugarController = TextEditingController(
    text: "126",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.share_outlined, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text(
          "تفاصيل القراءة",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // مؤشر القراءة الدائري
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: 0.7, // نسبة توضيحية
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.shade200,
                      color: const Color(0xFF2ECC71),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // حقل إدخال القراءة ليكون قابلاً للتعديل
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _sugarController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        "mg/dL",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // الحالة (مرتفع قليلاً)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 10, color: Colors.orange),
                  SizedBox(width: 8),
                  Text("مرتفع قليلاً", style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // بطاقة المعلومات الأساسية
            _buildInfoCard(
              title: "المعلومات الأساسية",
              children: [
                _buildInfoRow(
                  "الإثنين، 23 أكتوبر | 2:30 م",
                  "الوقت والتاريخ",
                  Icons.calendar_today_outlined,
                ),
                const Divider(),
                _buildInfoRow("ساعتين بعد الغداء", "الحالة", Icons.access_time),
              ],
            ),

            const SizedBox(height: 20),

            // زر تعديل القراءة
            ElevatedButton.icon(
              onPressed: () {
                // هنا تضع منطق الحفظ (Save logic)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "تم تحديث القراءة إلى: ${_sugarController.text}",
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit, size: 20),
              label: const Text(
                "تعديل القراءة",
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text(
                "حذف السجل",
                style: TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(height: 10),
            // تعليق الطبيب
            _buildDoctorNote(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String value, String label, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(width: 15),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.green, size: 20),
        ),
      ],
    );
  }

  Widget _buildDoctorNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "تعليق الطبيب",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.medical_services_outlined,
                color: Colors.green,
                size: 18,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "استمر في مراقبة النشاط البدني بعد هذه الوجبة. النتيجة جيدة ولكن حاول تقليل حصة النشويات قليلاً في المرة القادمة.",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }
}
