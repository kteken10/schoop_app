import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import '../../ui/device_app_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AppInfo> apps = [];
  bool loading = true;
  bool blurCurrent = false;
  bool blurOverlay = false;
  bool showSystem = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPermissionsAndApps();
  }

  Future<void> loadPermissionsAndApps() async {
    await Permission.systemAlertWindow.request();
    final all = await InstalledApps.getInstalledApps(!showSystem, true);
    setState(() {
      apps = all;
      loading = false;
    });
  }

  Future<void> promptUsageStatsPermission() async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Usage Access requis'),
        content: const Text('Active l\'accès aux statistiques d\'usage.'),
        actions: [
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Ouvrir les paramètres'),
          ),
        ],
      ),
    );
  }

  Future<void> startOverlay() async {
    if (!await FlutterOverlayWindow.isPermissionGranted()) {
      await FlutterOverlayWindow.requestPermission();
    }
    await FlutterOverlayWindow.showOverlay(
      height: 200,
      width: 200,
      alignment: OverlayAlignment.center,
      overlayTitle: 'Media Blur',
      overlayContent: '🔒 Flou actif',
    );
  }

  @override
  Widget build(BuildContext context) {
    final filter = searchController.text.toLowerCase();
    final filtered = apps.where((a) => a.name.toLowerCase().contains(filter));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Blur'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadPermissionsAndApps,
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              CheckedPopupMenuItem(
                value: 'toggleSystem',
                checked: showSystem,
                child: const Text('Afficher apps système'),
              ),
            ],
            onSelected: (_) => setState(() {
              showSystem = !showSystem;
              loading = true;
              loadPermissionsAndApps();
            }),
          ),
          Switch(
            value: blurCurrent,
            onChanged: (v) => setState(() => blurCurrent = v),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (loading)
            const Center(child: CircularProgressIndicator())
          else
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Rechercher une application',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => blurOverlay = !blurOverlay);
                    if (blurOverlay) {
                      startOverlay();
                    } else {
                      FlutterOverlayWindow.closeOverlay();
                    }
                  },
                  icon: Icon(blurOverlay ? Icons.stop : Icons.play_arrow),
                  label: Text(blurOverlay ? 'Arrêter le flou' : 'Activer le flou'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final app = filtered.elementAt(index);
                      return FutureBuilder<bool>(
                        future: InstalledApps.isSystemApp(app.packageName)
                            .then((value) => value ?? false),
                        builder: (_, snap) {
                          return DeviceAppCard(
                            app: app,
                            isSystemApp: snap.data ?? false,
                            onTap: () => InstalledApps.startApp(app.packageName),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          if (blurCurrent)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.black45),
              ),
            ),
        ],
      ),
    );
  }
}