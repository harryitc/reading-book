import 'package:flutter/material.dart';

enum ViewMode { grid, list }

/// Reusable view toggle button widget
/// Toggles between grid and list view modes
class ViewToggleButton extends StatelessWidget {
  final ViewMode currentMode;
  final ValueChanged<ViewMode> onModeChanged;

  const ViewToggleButton({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.grey[200],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleOption(
            icon: Icons.grid_view,
            isSelected: currentMode == ViewMode.grid,
            onPressed: () => onModeChanged(ViewMode.grid),
          ),
          _ToggleOption(
            icon: Icons.list,
            isSelected: currentMode == ViewMode.list,
            onPressed: () => onModeChanged(ViewMode.list),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  const _ToggleOption({
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
          ),
          child: Icon(
            icon,
            size: 20,
            color: isSelected
                ? Colors.white
                : (Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[400]
                    : Colors.grey[600]),
          ),
        ),
      ),
    );
  }
}
