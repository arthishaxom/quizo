import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SingleSelectButtonGroup extends StatefulWidget {
  final List<dynamic> options;
  final bool isSelectionRequired;
  final ValueChanged<Map<String, dynamic>?> onChanged;

  const SingleSelectButtonGroup({
    super.key,
    required this.options,
    this.isSelectionRequired = false,
    required this.onChanged,
  });

  @override
  SingleSelectButtonGroupState createState() => SingleSelectButtonGroupState();
}

class SingleSelectButtonGroupState extends State<SingleSelectButtonGroup> {
  Map<String, dynamic>? _selectedOption;

  void _onButtonPressed(
      Map<String, dynamic> option, bool selected, BuildContext context) {
    setState(() {
      if (_selectedOption == option) {
        if (!widget.isSelectionRequired) {
          _selectedOption = null;
        }
      } else {
        _selectedOption = option;
      }
      widget.onChanged(_selectedOption);
    });
  }

  @override
  Widget build(BuildContext context) {
    final shadcon = ShadTheme.of(context);
    return Column(
      // spacing: 8.0,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.options.map((option) {
        final isSelected = _selectedOption == option;
        return ChoiceChip(
          selectedColor: shadcon.colorScheme.primary,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          label: SizedBox(
            width: double.infinity,
            child: Text(option['description']),
          ),
          selected: isSelected,
          onSelected: (selected) => _onButtonPressed(option, selected, context),
        );
      }).toList(),
    );
  }
}
