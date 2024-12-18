// lib/features/gallery/presentation/screens/gallery_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../services/google_photos_service.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<String> _photos = [];
  final ImagePicker _picker = ImagePicker();
  final GooglePhotosService _photosService = GooglePhotosService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final appDir = await getApplicationDocumentsDirectory();
    final files = Directory(appDir.path)
        .listSync()
        .where((file) => file.path.endsWith('.jpg'))
        .map((file) => file.path)
        .toList();

    setState(() => _photos.addAll(files));
  }

  void _viewPhoto(String photoPath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 3.0,
              child: Image.file(File(photoPath)),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deletePhoto(String photoPath, int index) async {
    final file = File(photoPath);
    if (await file.exists()) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Delete Photo?', style: TextStyle(color: Colors.white)),
          content: const Text('This action cannot be undone.', style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await file.delete();
                setState(() => _photos.removeAt(index));
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Photo deleted')),
                  );
                }
              },
              child: Text('Delete', style: TextStyle(color: Colors.red[300])),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _takePhoto() async {
    try {
      setState(() => _isLoading = true);

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (photo != null) {
        // Save locally
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'devfest_${DateTime
            .now()
            .millisecondsSinceEpoch}.jpg';
        final savedImage = File('${appDir.path}/$fileName');
        await savedImage.writeAsBytes(await photo.readAsBytes());

        setState(() => _photos.add(savedImage.path));

        // Upload to Google Photos
        try {
          await _photosService.uploadPhoto(savedImage);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Photo uploaded to album successfully')),
            );
          }
        } catch (uploadError) {
          print('Upload error details: $uploadError'); // Add this debug print
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error uploading to album. Please try again.'),
                duration: const Duration(seconds: 5),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error taking photo: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _photos.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_library_outlined,
                  size: 64, color: AppColors.googleBlue),
              const SizedBox(height: 16),
              const Text(
                'No photos yet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Take photos at DevFest!',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        )
            : GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _photos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _viewPhoto(_photos[index]),
              onLongPress: () => _deletePhoto(_photos[index], index),
              child: Stack(
                  fit: StackFit.expand,
                  children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(_photos[index]),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
             right: 4,
             top: 4,
            child: GestureDetector(
              onTap: () => _deletePhoto(_photos[index], index),
             child: Container(
               padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delete,
             color: Colors.white,
             size: 20,
            ),
                ),
              ),
            ),
            ]
            ),
            );
          },
        ),
      ),
      floatingActionButton: _isLoading
          ? const CircularProgressIndicator()
          : ElevatedButton.icon(
        onPressed: _takePhoto,
        icon: const Icon(Icons.camera_alt),
        label: const Text('Take Photo'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.googleBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}