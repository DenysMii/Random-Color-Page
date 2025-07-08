import 'package:flutter/material.dart';

///Helper widget for color sliders
class ColorSliderWidget extends StatefulWidget {
  const ColorSliderWidget({
    required this.label,
    required this.colorValue,
    required this.onChanged,
    super.key,
  });

  ///Label of the color
  final String label;

  ///Value (0-255) of the color
  final double colorValue;

  ///
  final ValueChanged<double> onChanged;

  @override
  State<ColorSliderWidget> createState() => _ColorSliderWidgetState();
}

class _ColorSliderWidgetState extends State<ColorSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${widget.label}: ', style: const TextStyle(fontSize: 20)),
        Slider(
          value: widget.colorValue,
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: widget.onChanged,
        ),
        Text(
          '${widget.colorValue.round()}',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
