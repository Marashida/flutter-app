import 'package:flutter/material.dart';
import '../task.dart';

// TaskCard is a reusable widget — it knows how to display one Task object.
// It receives the task data and two callbacks from its parent screen.
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleComplete; // Called when checkbox is tapped
  final VoidCallback onTap;            // Called when card body is tapped

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOverdue =
        !task.isCompleted && task.dueDate.isBefore(DateTime.now());

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          // Highlight overdue tasks with a red border
          side: isOverdue
              ? const BorderSide(color: Colors.red, width: 1.5)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // Checkbox to mark task complete / incomplete
              Checkbox(
                value: task.isCompleted,
                activeColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (_) => onToggleComplete(),
              ),

              const SizedBox(width: 4),

              // Task info — takes remaining horizontal space
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with strikethrough when completed
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: task.isCompleted ? Colors.grey : Colors.black87,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Category icon + name, and due date
                    Row(
                      children: [
                        Icon(
                          _categoryIcon(task.category),
                          size: 13,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 3),
                        Text(
                          task.category,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: isOverdue ? Colors.red : Colors.grey[600],
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _formatDate(task.dueDate),
                          style: TextStyle(
                            fontSize: 12,
                            color: isOverdue ? Colors.red : Colors.grey[600],
                            fontWeight: isOverdue
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        if (isOverdue) ...[
                          const SizedBox(width: 4),
                          const Text(
                            'OVERDUE',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Priority badge
              _priorityBadge(task.priority),
            ],
          ),
        ),
      ),
    );
  }

  // Returns an icon based on category string
  IconData _categoryIcon(String category) {
    switch (category) {
      case 'School':
        return Icons.school_outlined;
      case 'Personal':
        return Icons.person_outline;
      case 'Health':
        return Icons.favorite_outline;
      case 'Work':
        return Icons.work_outline;
      case 'Finance':
        return Icons.attach_money;
      default:
        return Icons.label_outline;
    }
  }

  // Returns a colored chip for the priority level
  Widget _priorityBadge(String priority) {
    Color color;
    switch (priority) {
      case 'High':
        color = Colors.red;
        break;
      case 'Medium':
        color = Colors.orange;
        break;
      default:
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Formats DateTime into a readable string like "16 May 2026"
  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
