import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodePage extends StatefulWidget {
  const ScanQrCodePage({super.key});

  @override
  State<ScanQrCodePage> createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  final MobileScannerController controller = MobileScannerController();

  bool isScanned = false;
  String? scannedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          if (!isScanned)
            TextButton(
              onPressed: () {
                controller.stop();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) {
                if (isScanned) return;

                final List<Barcode> barcodes = capture.barcodes;

                if (barcodes.isEmpty) return;

                final String? value = barcodes.first.rawValue;

                if (value != null && value.isNotEmpty) {
                  setState(() {
                    isScanned = true;
                    scannedValue = value;
                  });

                  controller.stop();
                }
              },
            ),
          ),

          if (scannedValue != null)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Scanned Value',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          scannedValue!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isScanned = false;
                              scannedValue = null;
                            });

                            controller.start();
                          },
                          child: const Text('Scan Again'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
