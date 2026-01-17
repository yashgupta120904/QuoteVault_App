import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/model/user_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  File? _imageFile;
  bool hasChanged = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    if (widget.profile.imagePath != null) {
      _imageFile = File(widget.profile.imagePath!);
    }
  }

  Future<void> _pickImage() async {
    final picked =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
        hasChanged = true;
      });
    }
  }

  void _save() {
    Navigator.pop(
      context,
      widget.profile.copyWith(
        name: _nameController.text.trim(),
        imagePath: _imageFile?.path,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 64,
                backgroundColor: Colors.grey.shade900,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null
                    ? const Icon(Icons.camera_alt, size: 32)
                    : null,
              ),
            ),
            const SizedBox(height: 32),

            _label("FULL NAME"),
            TextField(
              controller: _nameController,
              onChanged: (_) => setState(() => hasChanged = true),
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(),
            ),

            const SizedBox(height: 24),

            _label("EMAIL"),
            TextField(
              readOnly: true,
              decoration: _inputDecoration(hint: widget.profile.email),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: hasChanged ? _save : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: const Color(0xFF3211D4),
              ),
              child: const Text("Save Changes"),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Discard changes"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 1.2,
            color: Colors.grey,
          ),
        ),
      );

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade900,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
