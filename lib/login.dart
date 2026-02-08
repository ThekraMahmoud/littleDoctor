import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // تأكد من إضافة هذا السطر
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("خطأ في تهيئة Firebase: $e");
  }
  runApp(const MyApp());
}

// إضافة كلاس MyApp المفقود
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DiaMate',
      theme: ThemeData(
        fontFamily: 'Tajawal', // تأكد من إضافة الخط في pubspec أو حذفه
        primarySwatch: Colors.green,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool isDoctor = false;
  String ageGroup = "أكبر من 14";
  bool isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  Future<void> _handleAuth() async {
    // التحقق من الحقول قبل الإرسال
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      _showSnackBar("يرجى ملء جميع الحقول", Colors.orange);
      return;
    }

    if (!isLogin && _nameController.text.trim().isEmpty) {
      _showSnackBar("يرجى إدخال الاسم", Colors.orange);
      return;
    }

    setState(() => isLoading = true);
    try {
      if (isLogin) {
        // تسجيل الدخول
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        _showSnackBar("تم تسجيل الدخول بنجاح", Colors.green);
      } else {
        // إنشاء حساب جديد
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );

        // حفظ البيانات في Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.user!.uid)
            .set({
              'name': _nameController.text.trim(),
              'role': isDoctor ? 'طبيب' : 'مريض',
              'age_group': ageGroup,
              'email': _emailController.text.trim(),
              'createdAt': FieldValue.serverTimestamp(),
            });
        _showSnackBar("تم إنشاء الحساب بنجاح", Colors.green);
      }
      // هنا يمكنك إضافة Navigator.push للانتقال للصفحة التالية
    } on FirebaseAuthException catch (e) {
      _showSnackBar(e.message ?? "حدث خطأ غير متوقع", Colors.redAccent);
    } catch (e) {
      _showSnackBar("خطأ: $e", Colors.redAccent);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.right),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF134E5E), Color(0xFF71B280)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.health_and_safety,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "DiaMate",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const Text(
              "شريكك الصحي الذكي",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            _toggleBtn(
                              "دخول",
                              isLogin,
                              () => setState(() => isLogin = true),
                            ),
                            _toggleBtn(
                              "حساب جديد",
                              !isLogin,
                              () => setState(() => isLogin = false),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      if (!isLogin) ...[
                        _prettyField(
                          "الاسم الكامل",
                          Icons.person_outline,
                          _nameController,
                        ),
                        const SizedBox(height: 20),
                      ],
                      _prettyField(
                        "البريد الإلكتروني",
                        Icons.alternate_email,
                        _emailController,
                      ),
                      const SizedBox(height: 20),
                      _prettyField(
                        "كلمة المرور",
                        Icons.lock_outline,
                        _passwordController,
                        isPass: true,
                      ),
                      if (!isLogin) _ageSection(),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: isLoading ? null : _handleAuth,
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF134E5E), Color(0xFF71B280)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    isLogin ? "تسجيل الدخول" : "ابدأ الآن",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleBtn(String title, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: active ? const Color(0xFF134E5E) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: active ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _prettyField(
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool isPass = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF134E5E)),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _ageSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerRight,
          child: Text("العمر", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _ageChip("أصغر من 14"),
            const SizedBox(width: 10),
            _ageChip("أكبر من 14"),
          ],
        ),
      ],
    );
  }

  Widget _ageChip(String label) {
    bool selected = ageGroup == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (val) => setState(() => ageGroup = label),
      selectedColor: const Color(0xFF71B280).withOpacity(0.2),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF134E5E) : Colors.black,
      ),
    );
  }
}
