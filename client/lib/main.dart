import 'dart:io';
import '../../server/src/prerender/prerender_service.dart';
import '../../server/src/seo/seo_optimizer.dart';

class FluserServer {
  final HttpServer _server;
  final PreRenderService _preRenderService;
  final SEOOptimizer _seoOptimizer;

  FluserServer(this._server, this._preRenderService, this._seoOptimizer);

  void start() {
    print('Fluser server is running on http://localhost:8080...');
    _server.listen((HttpRequest request) {
      handleRequest(request);
    });
  }

  void handleRequest(HttpRequest request) async {
    final path = request.uri.path;

    try {
      switch (path) {
        case '/':
          await _serveHomePage(request);
          break;
        case '/about':
          await _serveAboutPage(request);
          break;
        case '/prerender':
          _preRenderService.renderStaticPages();
          request.response
            ..statusCode = HttpStatus.ok
            ..write('<h1>Static pages rendered!</h1>');
          break;
        default:
          await _serveNotFoundPage(request);
      }
    } catch (e) {
      await _serveErrorPage(request, e.toString());
    }
  }

  Future<void> _serveHomePage(HttpRequest request) async {
    _seoOptimizer.generateMetaTags(
      'Welcome to Fluser',
      'Fluser is a Flutter framework for web applications.',
      'Flutter, web, framework'
    );
    request.response
      ..statusCode = HttpStatus.ok
      ..write('<h1>Welcome to Fluser!</h1>');
  }

  Future<void> _serveAboutPage(HttpRequest request) async {
    _seoOptimizer.generateMetaTags(
      'About Fluser',
      'Learn more about the Fluser framework.',
      'Fluser, about, framework'
    );
    request.response
      ..statusCode = HttpStatus.ok
      ..write('<h1>About Fluser</h1>');
  }

  Future<void> _serveNotFoundPage(HttpRequest request) async {
    request.response
      ..statusCode = HttpStatus.notFound
      ..write('<h1>404 Not Found</h1>');
  }

  Future<void> _serveErrorPage(HttpRequest request, String error) async {
    request.response
      ..statusCode = HttpStatus.internalServerError
      ..write('<h1>500 Internal Server Error</h1><p>$error</p>');
  }
}

Future<void> main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
  final preRenderService = PreRenderService();
  final seoOptimizer = SEOOptimizer();
  final fluserServer = FluserServer(server, preRenderService, seoOptimizer);
  
  fluserServer.start();
}