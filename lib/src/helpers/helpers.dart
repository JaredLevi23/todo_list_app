
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Helpers{

  // Choose image from gallery or camera
  static Future<String?> pickImageFrom( { required ImageSource source } ) async {

    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source, imageQuality: 25 );

    if (pickedFile == null) {
      return null;
    }

    final pathLocal = await getApplicationDocumentsDirectory();
    final img = await pickedFile.readAsBytes();
    const uuid = Uuid();

    String path = '${pathLocal.path}/${uuid.v4()}.png';
    File file = File( path );
    file.writeAsBytesSync( img );
    return path;
  }

  static Future<void> deleteImage( String path ) async {
    try {
      final file = File( path );
      await file.delete();
    } catch (_) {}
  }
}