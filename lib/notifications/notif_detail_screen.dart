import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Reusable detail screen for every notification square.
/// No AppBar, no back arrow — user uses the system back gesture/button.
class NotifDetailScreen extends StatefulWidget {
  final int notifId;
  const NotifDetailScreen({super.key, required this.notifId});

  @override
  State<NotifDetailScreen> createState() => _NotifDetailScreenState();
}

class _NotifDetailScreenState extends State<NotifDetailScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;

  String _photoPath = '';
  List<Map<String, String>> _texts = [];
  List<String> _photos = [];
  int _tabIndex = 0;

  final ImagePicker _picker = ImagePicker();

  String get _prefKey => 'notif_${widget.notifId}';

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _descCtrl = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefKey);
    if (raw != null) {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      setState(() {
        _nameCtrl.text = map['name'] as String? ?? '';
        _descCtrl.text = map['description'] as String? ?? '';
        _photoPath = map['photoPath'] as String? ?? '';
        final rawTexts = map['texts'] as List? ?? [];
        _texts = rawTexts.map((e) {
          if (e is Map) return Map<String, String>.from(e);
          return {'title': '', 'body': e.toString()};
        }).toList();
        _photos = List<String>.from(map['photos'] as List? ?? []);
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefKey,
      jsonEncode({
        'name': _nameCtrl.text,
        'description': _descCtrl.text,
        'photoPath': _photoPath,
        'texts': _texts,
        'photos': _photos,
      }),
    );
  }

  Future<String?> _pickImage() async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      return picked?.path;
    } on PlatformException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Image picker not available on this device')),
        );
      }
      return null;
    } on MissingPluginException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Image picker not supported — try on a real device')),
        );
      }
      return null;
    }
  }

  Future<void> _pickHeaderPhoto() async {
    final path = await _pickImage();
    if (path != null) {
      setState(() => _photoPath = path);
      _saveData();
    }
  }

  void _addText() {
    setState(() => _texts.add({'title': '', 'body': ''}));
    _saveData();
  }

  Future<void> _addPhoto() async {
    final path = await _pickImage();
    if (path != null) {
      setState(() => _photos.add(path));
      _saveData();
    }
  }

  // ─── Long-press delete: move text/photo to Messages ───

  Future<void> _onTextLongPress(int index) async {
    final title = _texts[index]['title'] ?? '';
    final label = title.isNotEmpty ? '"$title"' : 'this text entry';

    if (!mounted) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Move to Messages?'),
        content: Text('Are you sure you want to move $label to Messages?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('No')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Yes')),
        ],
      ),
    );
    if (confirm != true || !mounted) return;

    final removedText = _texts[index];
    setState(() => _texts.removeAt(index));
    _saveData();

    // Add to messages_moved
    final prefs = await SharedPreferences.getInstance();
    final movedRaw = prefs.getString('messages_moved') ?? '[]';
    final movedList = jsonDecode(movedRaw) as List;
    movedList.add({
      'notifId': widget.notifId,
      'charaName': removedText['title']?.isNotEmpty == true
          ? removedText['title']
          : 'Text entry',
      'fromSection': -1, // -1 means it's a text/photo item, not a square
      'fromIndex': -1,
      'type': 'text',
      'data': removedText,
    });
    await prefs.setString('messages_moved', jsonEncode(movedList));
  }

  Future<void> _onPhotoLongPress(int index) async {
    if (!mounted) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Move to Messages?'),
        content:
            const Text('Are you sure you want to move this photo to Messages?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('No')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Yes')),
        ],
      ),
    );
    if (confirm != true || !mounted) return;

    final removedPath = _photos[index];
    setState(() => _photos.removeAt(index));
    _saveData();

    final prefs = await SharedPreferences.getInstance();
    final movedRaw = prefs.getString('messages_moved') ?? '[]';
    final movedList = jsonDecode(movedRaw) as List;
    movedList.add({
      'notifId': widget.notifId,
      'charaName': 'Photo',
      'fromSection': -1,
      'fromIndex': -1,
      'type': 'photo',
      'data': removedPath,
    });
    await prefs.setString('messages_moved', jsonEncode(movedList));
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
        body: SafeArea(
          child: Column(
            children: [
              // ── Top info section (no back arrow) ──
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Photo square
                    GestureDetector(
                      onTap: _pickHeaderPhoto,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 112, 186, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _photoPath.isNotEmpty &&
                                File(_photoPath).existsSync()
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(File(_photoPath),
                                    fit: BoxFit.cover,
                                    width: 90,
                                    height: 90),
                              )
                            : const Center(
                                child: Icon(
                                    Icons.add_photo_alternate_outlined,
                                    color: Colors.white70,
                                    size: 36),
                              ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Name + Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _nameCtrl,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (_) {
                              setState(() {});
                              _saveData();
                            },
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _descCtrl,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Description',
                              hintStyle: TextStyle(color: Colors.white38),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            maxLines: null,
                            minLines: 1,
                            onChanged: (_) => _saveData(),
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
                          child: Text('Text',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)),
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
                          child: Text('Photos',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)),
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
      ),
    );
  }

  // ─── Text tab ───
  Widget _buildTextTab() {
    if (_texts.isEmpty) {
      return const Center(
        child: Text('Long press to add text',
            style: TextStyle(color: Colors.white70, fontSize: 16)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _texts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: GestureDetector(
            onLongPress: () => _onTextLongPress(index),
            child: Container(
              constraints: const BoxConstraints(minHeight: 200),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 112, 186, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: TextEditingController(
                        text: _texts[index]['title'] ?? ''),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Add a title...',
                      hintStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.only(bottom: 4),
                    ),
                    onChanged: (val) {
                      _texts[index]['title'] = val;
                      _saveData();
                    },
                  ),
                  const Divider(
                      color: Colors.white24, height: 1, thickness: 0.5),
                  const SizedBox(height: 4),
                  TextField(
                    controller: TextEditingController(
                        text: _texts[index]['body'] ?? ''),
                    maxLines: null,
                    minLines: 6,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 15),
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Type here...',
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                    onChanged: (val) {
                      _texts[index]['body'] = val;
                      _saveData();
                    },
                  ),
                ],
              ),
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
        child: Text('Long press to add photo',
            style: TextStyle(color: Colors.white70, fontSize: 16)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _photos.length,
      itemBuilder: (context, index) {
        final path = _photos[index];
        final file = File(path);
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: GestureDetector(
            onLongPress: () => _onPhotoLongPress(index),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 112, 186, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: file.existsSync()
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(file,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200),
                    )
                  : Center(
                      child: Text(path,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                          textAlign: TextAlign.center),
                    ),
            ),
          ),
        );
      },
    );
  }
}
