import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import '../../constants/colors.dart';
import '../../ui/animated_search_field.dart';
import '../../ui/app_filter.dart';
import '../../ui/branding_card.dart';
import '../../ui/device_app_card.dart';
import '../../ui/pulsing_avatar.dart';
import '../../ui/search_zone.dart';

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
  String? selectedAppType;
  final searchController = TextEditingController();
  final Map<String, bool> _appSystemStatusCache = {};

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    _loadApps();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  Future<void> _loadApps() async {
    setState(() => loading = true);
    await Permission.systemAlertWindow.request();
    
    try {
      final allApps = await InstalledApps.getInstalledApps(true, true);
      for (final app in allApps) {
        _appSystemStatusCache[app.packageName] = 
            await InstalledApps.isSystemApp(app.packageName) ?? false;
      }
      
      setState(() {
        apps = allApps;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
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

  List<AppInfo> _filterApps() {
    final filter = searchController.text.toLowerCase();
    
    return apps.where((app) {
      if (!app.name.toLowerCase().contains(filter)) {
        return false;
      }
      
      if (selectedAppType != null && selectedAppType != 'Toutes') {
        final isSystem = _appSystemStatusCache[app.packageName] ?? false;
        if (selectedAppType == 'Système' && !isSystem) return false;
        if (selectedAppType == 'Utilisateur' && isSystem) return false;
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredApps = _filterApps();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(
              width: 60, // Largeur réduite pour le PulsingAvatar
              child: PulsingAvatar(
                imagePath: 'assets/user_picture.png',
                isOnline: true,
              ),
            ),
           
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadApps,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Switch(
              value: blurCurrent,
              onChanged: (v) => setState(() => blurCurrent = v),
            ),
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
                const SizedBox(height: 16),
                BrandingCard(imagePath: 'assets/girl_smile.png'),
                Padding(
  padding: const EdgeInsets.all(16),
  child: Row(
    children: [
      Expanded(
        child: AnimatedSearchField(
          controller: searchController,
          onChanged: (value) => setState(() {}),
          hintText: 'Search app...',
        ),
      ),
      
    ],
  ),
),
                AppTypeFilter(
                  selectedType: selectedAppType,
                  onTypeSelected: (type) {
                    setState(() {
                      selectedAppType = type;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() => blurOverlay = !blurOverlay);
                        if (blurOverlay) {
                          startOverlay();
                        } else {
                          FlutterOverlayWindow.closeOverlay();
                        }
                      },
                      icon: Icon(
                        blurOverlay ? Icons.stop : Icons.play_arrow,
                        size: 20,
                      ),
                      label: Text(
                        blurOverlay ? 'Arrêter le flou' : 'Activer le flou',
                        style: const TextStyle(fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredApps.length,
                    itemBuilder: (context, index) {
                      final app = filteredApps[index];
                      final isSystem = _appSystemStatusCache[app.packageName] ?? false;
                      
                      return DeviceAppCard(
                        app: app,
                        isSystemApp: isSystem,
                        onTap: () => InstalledApps.startApp(app.packageName),
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