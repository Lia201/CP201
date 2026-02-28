import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Reusable detail screen for every notification square.
/// All data (name, description, text entries, photo paths) are stored in
/// SharedPreferences keyed by [notifId].
class NotifDetailScreen extends StatefulWidget {
  final int notifId;
  const NotifDetailScreen({super.key, required this.notifId});

  @override
  State<NotifDetailScreen> createState() => _NotifDetailScreenState();
}

class _NotifDetailScreenState extends State<NotifDetailScreen> {
  String _name = '';
  String _description = '';
  String _photoPath = '';
  List<String> _texts = [];
  List<String> _photos = [];
  int _tabIndex = 0; // 0 = Text, 1 = Photos

  String get _prefKey => 'notif_${widget.notifId}';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefKey);
    if (raw != null) {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      setState(() {
        _name = map['name'] as String? ?? '';
        _description = map['description'] as String? ?? '';
        _photoPath = map['photoPath'] as String? ?? '';
        _texts = List<String>.from(map['texts'] as List? ?? []);
        _photos = List<String>.from(map['photos'] as List? ?? []);
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefKey,
      jsonEncode({
        'name': _name,
        'description': _description,
        'photoPath': _photoPath,
        'texts': _texts,
        'photos': _photos,
      }),
    );
  }

  // ─── Editing helpers ───

  Future<void> _editName() async {
    final controller = TextEditingController(text: _name);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) {
      setState(() => _name = result);
      _saveData();
    }
  }

  Future<void> _editDescription() async {
    final controller = TextEditingController(text: _description);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Description'),
        content: TextField(controller: controller, autofocus: true, maxLines: 3),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) {
      setState(() => _description = result);
      _saveData();
    }
  }

  Future<void> _editPhotoPath() async {
    final controller = TextEditingController(text: _photoPath);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Set Photo Path'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: '/path/to/photo.jpg'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) {
      setState(() => _photoPath = result);
      _saveData();
    }
  }

  // ─── Add items via long-press ───

  void _addText() {
    setState(() {
      _texts.add('');
    });
    _saveData();
  }

  void _addPhoto() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Photo Path'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: '/path/to/photo.jpg'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      setState(() {
        _photos.add(result);
      });
      _saveData();
    }
  }

  // ─── Build ───

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (_tabIndex == 0) {
          _addText();
        } else {
          _addPhoto();
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 93, 176, 255),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            _name.isEmpty ? 'Notification ${widget.notifId}' : _name,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            // ── Top info section ──
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo square (left)
                  GestureDetector(
                    onTap: _editPhotoPath,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 112, 186, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _photoPath.isNotEmpty && File(_photoPath).existsSync()
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(_photoPath),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.white70,
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Name + Description (right of photo)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _editName,
                          child: Text(
                            _name.isEmpty ? 'Tap to set name' : _name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: _editDescription,
                          child: Text(
                            _description.isEmpty ? 'Tap to set description' : _description,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Tab buttons ──
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _tabIndex = 0),
                    child: Container(
                      height: 48,
                      color: _tabIndex == 0
                          ? Colors.blue
                          : const Color.fromARGB(255, 112, 186, 255),
                      child: const Center(
                        child: Text(
                          'Text',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _tabIndex = 1),
                    child: Container(
                      height: 48,
                      color: _tabIndex == 1
                          ? Colors.blue
                          : const Color.fromARGB(255, 112, 186, 255),
                      child: const Center(
                        child: Text(
                          'Photos',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Tab content ──
            Expanded(
              child: _tabIndex == 0 ? _buildTextTab() : _buildPhotosTab(),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Text tab ───
  Widget _buildTextTab() {
    if (_texts.isEmpty) {
      return const Center(
        child: Text(
          'Long press to add text',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _texts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 112, 186, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: TextEditingController(text: _texts[index]),
              maxLines: null,
              expands: true,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              decoration: const InputDecoration.collapsed(
                hintText: 'Type here...',
                hintStyle: TextStyle(color: Colors.white54),
              ),
              onChanged: (val) {
                _texts[index] = val;
                _saveData();
              },
            ),
          ),
        );
      },
    );
  }

  // ─── Photos tab ───
  Widget _buildPhotosTab() {
    if (_photos.isEmpty) {
      return const Center(
        child: Text(
          'Long press to add photo',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _photos.length,
      itemBuilder: (context, index) {
        final path = _photos[index];
        final file = File(path);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 112, 186, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: file.existsSync()
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(file, fit: BoxFit.cover, width: double.infinity, height: 200),
                  )
                : Center(
                    child: Text(
                      path,
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
