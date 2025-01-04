import 'dart:io';
import 'dart:math';

class SEOOptimizer {
  final String sitemapFilePath = 'sitemap.xml';

  void generateMetaTags(String title, String description, String keywords) {
    String metaTags = '''
    <meta name="title" content="$title">
    <meta name="description" content="$description">
    <meta name="keywords" content="$keywords">
    ''';
    print('Generated Meta Tags:');
    print(metaTags);
  }

  void injectStructuredData(Map<String, dynamic> data) {
    String structuredData = '''
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "${data['@type']}",
      "name": "${data['name']}",
      "description": "${data['description']}",
      "url": "${data['url']}"
    }
    </script>
    ''';
    print('Injected Structured Data:');
    print(structuredData);
  }

  void analyzeContent(String content) {
    print('Analyzing content for SEO best practices...');

    // Example checks
    int keywordCount = _countKeywords(content, 'Flutter');
    double keywordDensity = _calculateKeywordDensity(content, 'Flutter');

    print('Keyword "Flutter" found $keywordCount times.');
    print('Keyword density: ${keywordDensity.toStringAsFixed(2)}%');

    if (keywordDensity < 1.0) {
      print('Consider using the keyword "Flutter" more frequently.');
    } else if (keywordDensity > 3.0) {
      print(
          'Keyword density is high; consider reducing usage to avoid keyword stuffing.');
    }

    // Check for readability (simple check)
    if (_isReadable(content)) {
      print('Content is readable.');
    } else {
      print(
          'Content may be difficult to read; consider simplifying your language.');
    }
  }

  void generateSitemap(List<String> pages) {
    print('Generating sitemap...');
    final sitemapContent = StringBuffer()
      ..writeln('<?xml version="1.0" encoding="UTF-8"?>')
      ..writeln(
          '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap-image/1.1">');

    for (var page in pages) {
      sitemapContent
        ..writeln('  <url>')
        ..writeln('    <loc>http://yourdomain.com$page</loc>')
        ..writeln('    <lastmod>${DateTime.now().toIso8601String()}</lastmod>')
        ..writeln('    <changefreq>weekly</changefreq>')
        ..writeln('    <priority>0.5</priority>')
        ..writeln('  </url>');
    }

    sitemapContent.writeln('</urlset>');

    File(sitemapFilePath).writeAsStringSync(sitemapContent.toString());
    print('Sitemap generated at $sitemapFilePath');
  }

  int _countKeywords(String content, String keyword) {
    return RegExp(r'\b$keyword\b', caseSensitive: false)
        .allMatches(content)
        .length;
  }

  double _calculateKeywordDensity(String content, String keyword) {
    int keywordCount = _countKeywords(content, keyword);
    int totalWords = content.split(RegExp(r'\s+')).length;
    return (keywordCount / totalWords) * 100;
  }

  bool _isReadable(String content) {
    // Simple readability check based on average sentence length
    List<String> sentences = content.split(RegExp(r'[.!?]'));
    int totalWords = content.split(RegExp(r'\s+')).length;
    double averageSentenceLength = totalWords / sentences.length;

    return averageSentenceLength <=
        20; // Consider 20 words as a threshold for readability
  }
}
