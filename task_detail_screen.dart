import 'package:flutter/material.dart';
import '../task.dart';

// TaskDetailScreen receives the task object and three callback functions.
// Callbacks let this screen tell its parent (TaskListScreen) when something changes.
class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onToggle;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onEdit,
    required this.onToggle,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  // Confirm deletion with an AlertDialog before proceeding
  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text(
          'Are you sure you want to delete "${widget.task.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), // Close dialog, do nothing
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);          // Close dialog
              widget.onDelete();           // Tell parent to remove this task
              Navigator.pop(context);      // Go back to task list
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

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

  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final bool isOverdue =
        !task.isCompleted && task.dueDate.isBefore(DateTime.now());
    final Color priorityColor = _priorityColor(task.priority);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          // Edit button — opens the same bottom sheet with pre-filled data
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Task',
            onPressed: () {
              widget.onEdit();      // Opens bottom sheet from parent
              Navigator.pop(context); // Return to list so edits show properly
            },
          ),
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete Task',
            onPressed: _confirmDelete,
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Task title ──
            Text(
              task.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: task.isCompleted ? Colors.grey : Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            // ── Status + Priority row ──
            Row(
              children: [
                // Completion status chip
                _statusChip(task.isCompleted),
                const SizedBox(width: 10),
                // Priority chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: priorityColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.flag_rounded, size: 14, color: priorityColor),
                      const SizedBox(width: 4),
                      Text(
                        '${task.priority} Priority',
                        style: TextStyle(
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),

            // ── Description ──
            _detailSection(
              icon: Icons.description_outlined,
              label: 'Description',
              content: task.description,
            ),

            const SizedBox(height: 16),

            // ── Category ──
            _detailRow(
              icon: _categoryIcon(task.category),
              label: 'Category',
              value: task.category,
              valueColor: Colors.blueGrey,
            ),

            const SizedBox(height: 12),

            // ── Due Date ──
            _detailRow(
              icon: Icons.calendar_today_outlined,
              label: 'Due Date',
              value: _formatDate(task.dueDate),
              valueColor: isOverdue ? Colors.red : Colors.black87,
              trailing: isOverdue
                  ? const Text(
                      ' — OVERDUE',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  : null,
            ),

            const SizedBox(height: 30),

            // ── Toggle Complete Button ──
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: task.isCompleted
                      ? Colors.orange.shade700
                      : const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(task.isCompleted
                    ? Icons.refresh_rounded
                    : Icons.check_circle_outline),
                label: Text(
                  task.isCompleted
                      ? 'Mark as Incomplete'
                      : 'Mark as Complete',
                  style: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  widget.onToggle(); // Tell parent to flip isCompleted
                  setState(() {});   // Rebuild THIS screen to reflect the change
                },
              ),
            ),

            const SizedBox(height: 12),

            // ── Delete Button ──
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete Task', style: TextStyle(fontSize: 16)),
                onPressed: _confirmDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A chip showing whether the task is done or pending
  Widget _statusChip(bool isCompleted) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green.withOpacity(0.15)
            : Colors.orange.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted ? Colors.green : Colors.orange,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCompleted ? Icons.check_circle_outline : Icons.hourglass_empty,
            size: 14,
            color: isCompleted ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 4),
          Text(
            isCompleted ? 'Completed' : 'Pending',
            style: TextStyle(
              color: isCompleted ? Colors.green : Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // A section with a heading and multi-line content (used for description)
  Widget _detailSection({
    required IconData icon,
    required String label,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF2E7D32)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            content,
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
        ),
      ],
    );
  }

  // A single-line detail row with icon, label, and value
  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
    Color valueColor = Colors.black87,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF2E7D32)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
}
