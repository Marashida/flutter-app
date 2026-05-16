import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ── REPLACE EVERYTHING BELOW WITH YOUR OWN REAL DETAILS ──
    const String fullName = 'Jane Akosua Mensah';       // YOUR full name
    const String studentId = 'SCM/SE/22/0042';           // YOUR student ID
    const String programme = 'BSc. Software Engineering'; // YOUR programme
    const String initials = 'JAM';                        // YOUR initials
    const String bio =
        'I am a passionate software engineering student with a love for '
        'mobile development and problem solving. I enjoy building apps that '
        'make everyday life simpler and more organised.';

    // Your 3 personal goals for the semester — make these real
    final List<String> semesterGoals = [
      'Complete all coursework submissions before their deadlines',
      'Build at least two personal Flutter projects outside class',
      'Improve my understanding of data structures and algorithms',
    ];
    // ─────────────────────────────────────────────────────────

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),

            // Circular avatar showing initials
            CircleAvatar(
              radius: 55,
              backgroundColor: const Color(0xFF2E7D32),
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Full name
            Text(
              fullName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B5E20),
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 6),

            // Student ID chip
            Chip(
              label: Text(
                studentId,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: const Color(0xFF2E7D32),
            ),

            const SizedBox(height: 4),

            // Programme
            Text(
              programme,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[700],
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 28),

            // Divider with label
            _sectionHeader(context, Icons.info_outline, 'About Me'),
            const SizedBox(height: 10),

            // Bio card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  bio,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        color: Colors.grey[800],
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _sectionHeader(context, Icons.flag_outlined, 'Semester Goals'),
            const SizedBox(height: 10),

            // Goals list
            ...semesterGoals.asMap().entries.map((entry) {
              final int index = entry.key;
              final String goal = entry.value;

              return Card(
                elevation: 1,
                margin: const EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFF2E7D32),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  title: Text(
                    goal,
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ),
              );
            }),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper widget for section headers — avoids repeating the same Row code
  Widget _sectionHeader(BuildContext context, IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2E7D32), size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B5E20),
              ),
        ),
        const SizedBox(width: 10),
        const Expanded(child: Divider()),
      ],
    );
  }
}
