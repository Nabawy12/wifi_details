import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WifiCheckScreen(),
    );
  }
}

class WifiCheckScreen extends StatefulWidget {
  @override
  _WifiCheckScreenState createState() => _WifiCheckScreenState();
}

class _WifiCheckScreenState extends State<WifiCheckScreen> {
  String _wifiName = 'غير معروف';
   String _requiredWifiName = '"ElBoshy"'; // اسم الشبكة المطلوبة

  @override
  void initState() {
    super.initState();
    _checkWifiConnection();
  }

  Future<void> _checkWifiConnection() async {
    final info = NetworkInfo();
    try {
      // الحصول على اسم الشبكة وتنظيفه
      String? wifiName = (await info.getWifiName())?.trim();

      setState(() {
        _wifiName = wifiName ?? 'غير معروف';
      });

      if (wifiName != null && wifiName.toLowerCase() == _requiredWifiName.toLowerCase()) {
        _showMessage('متصل بالشبكة المطلوبة: $_wifiName');
      } else {
        print("WIFINAME+++++++++++++++++++++++++++++++++${_wifiName}");
        print("WIFIREQUIRED=============================${_requiredWifiName}");
        _showMessage('لست متصلًا بالشبكة المطلوبة!');
      }
    } catch (e) {
      _showMessage('حدث خطأ أثناء التحقق من الشبكة: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التحقق من شبكة الواي فاي'),
      ),
      body: Center(
        child: Text(
          'اسم الشبكة الحالي: $_wifiName',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
