import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    printUsage();
    return;
  }

  final command = args[0];

  switch (command) {
    case 'create':
      if (args.length < 2) {
        print('Please provide a project name.');
      } else {
        createProject(args[1]);
      }
      break;
    case 'serve':
      serveProject();
      break;
    case 'build':
      buildProject();
      break;
    case 'analyze':
      analyzeSEO();
      break;
    case 'prerender':
      prerenderPages();
      break;
    default:
      print('Unknown command: $command');
      printUsage();
  }
}

void printUsage() {
  print('Fluser CLI Tool');
  print('Usage: fluser <command> [options]');
  print('Commands:');
  print('  create <project_name>  Create a new Fluser project');
  print('  serve                   Start the development server');
  print('  build                   Build the project for production');
  print('  analyze                 Analyze the project for SEO best practices');
  print('  prerender               Render static pages for the project');
}

void createProject(String projectName) {
  final projectDir = Directory(projectName);

  if (projectDir.existsSync()) {
    print(
        'Project "$projectName" already exists. Please choose a different name.');
    return;
  }

  // Create project directory
  projectDir.createSync();
  print('Created project directory: $projectName');

  // Create subdirectories
  Directory('${projectDir.path}/lib').createSync(recursive: true);
  Directory('${projectDir.path}/server/src').createSync(recursive: true);
  Directory('${projectDir.path}/client/lib').createSync(recursive: true);
  Directory('${projectDir.path}/cli/bin').createSync(recursive: true);

  // Create initial files
  File('${projectDir.path}/cli/bin/fluser.dart').writeAsStringSync('''
import 'dart:io';

void main() {
  print('Welcome to Fluser CLI!');
}
''');

  File('${projectDir.path}/server/src/main.dart').writeAsStringSync('''
import 'dart:io';

void main() {
  print('Fluser server is running...');
}
''');

  File('${projectDir.path}/client/lib/main.dart').writeAsStringSync('''
void main() {
  print('Fluser client is running...');
}
''');

  print('Project "$projectName" created successfully!');
}

void serveProject() {
  // Logic to start the development server
  print('Starting the Fluser development server...');

  // Here you would typically start the server and enable hot reload
  Process.run('dart', ['server/src/main.dart']).then((result) {
    print(result.stdout);
    print(result.stderr);
  });
}

void buildProject() {
  // Logic to build the project for production
  print('Building the Fluser project for production...');
  // Here you would typically compile the project and optimize assets
}

void analyzeSEO() {
  // Logic to analyze the project for SEO best practices
  print('Analyzing the Fluser project for SEO...');
  // Here you would typically run SEO checks and provide feedback
}

void prerenderPages() {
  // Logic to trigger the pre-rendering of static pages
  print('Rendering static pages...');
  // Here you would typically call the PreRenderService to render pages
}
