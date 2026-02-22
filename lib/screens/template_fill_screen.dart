import 'package:flutter/material.dart';
import '../services/note_service.dart';
import 'qr_share_screen.dart';

class TemplateFillScreen extends StatefulWidget {
  final String templateTitle;
  final List<String> fields;

  const TemplateFillScreen({
    super.key,
    required this.templateTitle,
    required this.fields,
  });

  @override
  State<TemplateFillScreen> createState() => _TemplateFillScreenState();
}

class _TemplateFillScreenState extends State<TemplateFillScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final NoteService _noteService = NoteService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      _controllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _buildNoteContent() {
    final buffer = StringBuffer();
    for (final field in widget.fields) {
      final value = _controllers[field]!.text.trim();
      buffer.writeln('$field:');
      buffer.writeln(value.isEmpty ? 'N/A' : value);
      buffer.writeln();
    }
    return buffer.toString();
  }

  Future<void> _saveNote() async {
    setState(() => _isSaving = true);
    try {
      final content = _buildNoteContent();
      await _noteService.addNote(widget.templateTitle, content);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
    setState(() => _isSaving = false);
  }

  void _shareAsQr() {
    final content = _buildNoteContent();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QrShareScreen(
          noteId: '',
          title: widget.templateTitle,
          content: content,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.templateTitle,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code, color: Colors.white),
            onPressed: _shareAsQr,
          ),
          _isSaving
              ? const Padding(
            padding: EdgeInsets.all(12),
            child: CircularProgressIndicator(color: Colors.white),
          )
              : IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: widget.fields.map((field) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  field,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _controllers[field],
                  maxLines: field == 'Objective' ||
                      field == 'Experience' ||
                      field == 'Skills' ||
                      field == 'Discussion Points' ||
                      field == 'Action Items' ||
                      field == 'Today I did' ||
                      field == 'Agenda'
                      ? 4
                      : 1,
                  decoration: InputDecoration(
                    hintText: 'Enter $field',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}