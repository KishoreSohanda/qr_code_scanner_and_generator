import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrCodePage extends StatefulWidget {
  const GenerateQrCodePage({super.key});

  @override
  State<GenerateQrCodePage> createState() => _GenerateQrCodePageState();
}

class _GenerateQrCodePageState extends State<GenerateQrCodePage> {
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generate Qr Code')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (urlController.text.isNotEmpty) ...[
                  QrImageView(
                    data: urlController.text,
                    version: QrVersions.auto,
                    size: 200,
                  ),
                  SizedBox(height: 20),
                ],
                TextFormField(
                  controller: urlController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Data',
                    hintText: 'Enter Your Data',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('Generate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
