import 'dart:io';

// Pre-renderer service implementation
class PreRenderService {
  final String buildDirectory = 'build';

  PreRenderService() {
    _createBuildDirectory();
  }

  void _createBuildDirectory() {
    final dir = Directory(buildDirectory);
    if (!dir.existsSync()) {
      dir.createSync();
      print('Created build directory: $buildDirectory');
    }
  }

  void renderStaticPages() {
    print('Rendering static pages...');
    // Example of rendering static pages
    List<String> staticPages = ['/about', '/contact', '/products'];

    for (var page in staticPages) {
      // Use the page variable to create the file path
      String filePath = '$buildDirectory$page.html';
      File(filePath).writeAsStringSync('<h1>$page Page</h1>');
      print('Rendered static page: $filePath');
    }
  }

  void renderDynamicPage(String path, Map<String, dynamic> data) {
    print('Rendering dynamic page for $path...');
    // Simulate rendering a dynamic page with data
    String content = '<h1>${data['title']}</h1><p>${data['description']}</p>';
    File('$buildDirectory$path.html').writeAsStringSync(content);
    print('Rendered dynamic page: $path');
  }
}
