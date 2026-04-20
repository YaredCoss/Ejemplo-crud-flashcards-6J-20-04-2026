import 'dart:io';

/// Script interactivo para enviar el proyecto a GitHub.
/// Diseñado para estudiantes de preparatoria.
void main() async {
  print('========================================');
  print('🚀 Agente de Envío a GitHub');
  print('========================================');

  // 1. Preguntar por el link del repositorio
  stdout.write('🔗 Introduce el link de tu nuevo repositorio de GitHub: ');
  String? repoLink = stdin.readLineSync();

  if (repoLink == null || repoLink.isEmpty) {
    print('❌ Error: El link del repositorio no puede estar vacío.');
    return;
  }

  // 2. Preguntar por el commit
  stdout.write('📝 Introduce el mensaje del commit: ');
  String? commitMessage = stdin.readLineSync();

  if (commitMessage == null || commitMessage.isEmpty) {
    print('❌ Error: El mensaje del commit no puede estar vacío.');
    return;
  }

  // 3. Preguntar por la rama (default main)
  stdout.write('🌿 Nombre de la rama (presiona Enter para "main"): ');
  String? branchName = stdin.readLineSync();
  if (branchName == null || branchName.isEmpty) {
    branchName = 'main';
  }

  print('\n----------------------------------------');
  print('⏳ Iniciando proceso de envío...');
  print('----------------------------------------\n');

  try {
    // Inicializar git si no existe
    await runCommand('git', ['init']);
    
    // Agregar todos los archivos
    await runCommand('git', ['add', '.']);
    
    // Crear el commit
    await runCommand('git', ['commit', '-m', commitMessage]);
    
    // Establecer la rama
    await runCommand('git', ['branch', '-M', branchName]);
    
    // Configurar el remoto
    // Intentamos agregar 'origin', si ya existe lo actualizamos
    var remoteResult = await Process.run('git', ['remote', 'add', 'origin', repoLink]);
    if (remoteResult.exitCode != 0) {
      await runCommand('git', ['remote', 'set-url', 'origin', repoLink]);
    }
    
    // Envío final
    print('🚀 Subiendo archivos a GitHub...');
    await runCommand('git', ['push', '-u', 'origin', branchName]);

    print('\n ✅ ¡Proyecto enviado con éxito a GitHub! ✨');
  } catch (e) {
    print('\n ❌ Ocurrió un error durante el proceso: $e');
  }
}

/// Función auxiliar para ejecutar comandos y mostrar su salida
Future<void> runCommand(String command, List<String> args) async {
  print('▶️ Ejecutando: $command ${args.join(' ')}');
  var result = await Process.run(command, args);
  
  if (result.stdout.toString().isNotEmpty) {
    print(result.stdout);
  }
  
  if (result.stderr.toString().isNotEmpty && result.exitCode != 0) {
    print('⚠️ Error: ${result.stderr}');
  }
}
