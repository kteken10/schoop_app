import 'package:flutter/material.dart';

class AnimatedSearchField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  const AnimatedSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search...',
  });

  @override
  State<AnimatedSearchField> createState() => _AnimatedSearchFieldState();
}

class _AnimatedSearchFieldState extends State<AnimatedSearchField> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isSearching ? 200 : 0,
          height: 40,
          curve: Curves.easeInOut,
          child: _isSearching
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 132, 177, 254)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: widget.hintText,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                )
              : null,
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 22,
          child: IconButton(
            icon: const Icon(Icons.search, color: Color.fromARGB(255, 132, 177, 254)),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  widget.controller.clear();
                  widget.onChanged('');
                }
              });
            },
          ),
        ),
      ],
    );
  }
}