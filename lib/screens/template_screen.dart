import 'package:flutter/material.dart';
import 'template_fill_screen.dart';

class TemplateScreen extends StatelessWidget {
  const TemplateScreen({super.key});

  final List<Map<String, dynamic>> templates = const [
    {
      'title': 'CV / Resume',
      'icon': Icons.person,
      'color': Colors.blue,
      'description': 'Professional curriculum vitae template',
      'fields': [
        'Full Name',
        'Email',
        'Phone',
        'Address',
        'Objective',
        'Education',
        'Experience',
        'Skills',
      ],
    },
    {
      'title': 'Daily Journal',
      'icon': Icons.book,
      'color': Colors.green,
      'description': 'Track your daily thoughts and activities',
      'fields': [
        'Date',
        'Mood',
        'Today I did',
        'What went well',
        'What could be better',
        'Grateful for',
        'Tomorrow\'s goals',
      ],
    },
    {
      'title': 'Meeting Notes',
      'icon': Icons.groups,
      'color': Colors.orange,
      'description': 'Organize your meeting notes effectively',
      'fields': [
        'Meeting Title',
        'Date & Time',
        'Attendees',
        'Agenda',
        'Discussion Points',
        'Action Items',
        'Next Meeting Date',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Choose Template',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: templates.length,
          itemBuilder: (context, index) {
            final template = templates[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (template['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    template['icon'] as IconData,
                    color: template['color'] as Color,
                    size: 30,
                  ),
                ),
                title: Text(
                  template['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    template['description'] as String,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TemplateFillScreen(
                        templateTitle: template['title'] as String,
                        fields: template['fields'] as List<String>,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}