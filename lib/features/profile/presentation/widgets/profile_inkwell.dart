import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';

class ProfileInkwell extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileInkwell({
    super.key,
    required,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 50,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon),
                      const Gap(
                        height: 0,
                        width: 8,
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
