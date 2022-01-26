import 'package:battery_plus/battery_plus.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:integrazioni_telefono/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:r_scan/r_scan.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController? controller;
  bool isRunningQrScanningProcess = false;

  @override
  void initState() {
    super.initState();

    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void run() async {
    try {
      if (isRunningQrScanningProcess) {
        print("isRunningQrScanningProcess");
        return;
      }

      setState(() {
        isRunningQrScanningProcess = true;
      });

      if (await hasEnoughBatteryLevelToRun() == false) {
        print("hasEnoughBatteryLevelToRun");
        showError("Livello batteria non sufficiente a continuare l'operazione.");
        return;
      }

      if (await canOpenCamera() == false) {
        print("canOpenCamera");
        showError("L'app non ha i permessi per accedere alla fotocamera.");
        return;
      }

      final filepath = await takePicture();
      print("filepath");
      final url = await scanPictureForQrCodeUrl(filepath);
      print("url");
      await openWebsite(url);
      print("openWebsite");

      setState(() {
        isRunningQrScanningProcess = false;
      });
    } catch (_) {
      setState(() {
        isRunningQrScanningProcess = false;
      });
    }
  }

  Future<bool> hasEnoughBatteryLevelToRun() async {
    final batteryLevel = await Battery().batteryLevel;
    return batteryLevel > 5;
  }

  Future<bool> canOpenCamera() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    return status.isGranted;
  }

  Future<String> takePicture() async {
    if (controller!.value.isTakingPicture) {
      await Future.delayed(Duration(milliseconds: 100));
      return takePicture();
    }

    XFile file = await controller!.takePicture();
    return file.path;
  }

  Future<String> scanPictureForQrCodeUrl(String filepath) async {
    final result = await RScan.scanImagePath(filepath);
    return result.message!;
  }

  Future<void> openWebsite(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void showError(String error) {
    setState(() {
      isRunningQrScanningProcess = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error),
    ));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !(controller?.value.isInitialized ?? false)
          ? Container()
          : Stack(
              children: [
                cameraLayer(),
                capturePhotoButton(),
              ],
            ),
    );
  }

  Widget cameraLayer() => Positioned(
        top: 0,
        bottom: 0,
        child: CameraPreview(controller!),
      );

  Widget capturePhotoButton() => Positioned(
        left: 0,
        right: 0,
        bottom: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bounceable(
              onTap: run,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white70, width: 4),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        spreadRadius: 4,
                        color: Colors.black12,
                      ),
                    ]),
                child: isRunningQrScanningProcess
                    ? CircularProgressIndicator()
                    : Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(Icons.qr_code),
                        ),
                      ),
              ),
            ),
          ],
        ),
      );
}
