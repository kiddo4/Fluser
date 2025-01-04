import 'dart:io';
import 'dart:convert';

class PreRenderService {
  final String buildDirectory = 'build';
  final String cacheDirectory = 'cache';
  final List<String> staticPages = ['/about', '/contact', '/products'];

  PreRenderService() {
    _createBuildDirectory();
    _createCacheDirectory();
  }

  void _createBuildDirectory() {
    final dir = Directory(buildDirectory);
    if (!dir.existsSync()) {
      dir.createSync();
      print('Created build directory: $buildDirectory');
    }
  }

  void _createCacheDirectory() {
    final dir = Directory(cacheDirectory);
    if (!dir.existsSync()) {
      dir.createSync();
      print('Created cache directory: $cacheDirectory');
    }
  }

  void renderStaticPages() {
    print('Rendering static pages...');
    for (var page in staticPages) {
      String filePath = '$buildDirectory$page.html';
      File(filePath).writeAsStringSync('<h1>$page Page</h1>');
      print('Rendered static page: $filePath');
      cacheRenderedPage(page);
    }
  }

  void renderDynamicPage(String path, Map<String, dynamic> data) {
    print('Rendering dynamic page for $path...');
    String content = '<h1>${data['title']}</h1><p>${data['description']}</p>';
    File('$buildDirectory$path.html').writeAsStringSync(content);
    print('Rendered dynamic page: $path');
    cacheRenderedPage(path);
  }

  void cacheRenderedPage(String path) {
    String cacheFilePath = '$cacheDirectory$path.cache';
    File(cacheFilePath).writeAsStringSync('Cached content for $path');
    print('Cached rendered page: $cacheFilePath');
  }

  void clearCache() {
    print('Clearing cache...');
    final cacheDir = Directory(cacheDirectory);
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      print('Cache cleared.');
    } else {
      print('No cache to clear.');
    }
  }

  void renderAllPages() {
    renderStaticPages();
    List<Map<String, dynamic>> dynamicPages = [
      {
        'path': '/user/1',
        'title': 'User 1',
        'description': 'Details about User 1'
      },
      {
        'path': '/user/2',
        'title': 'User 2',
        'description': 'Details about User 2'
      },
    ];

    for (var page in dynamicPages) {
      renderDynamicPage(page['path'], page);
    }

    print('All pages rendered successfully.');
  }

  void loadConfiguration() {
    try {
      final configFile = File('config.json');
      if (configFile.existsSync()) {
        final configContent = configFile.readAsStringSync();
        final config = jsonDecode(configContent);
        print('Loaded configuration: $config');
      } else {
        print('Configuration file not found. Using default settings.');
      }
    } catch (e) {
      print('Error loading configuration: $e');
    }
  }
}
