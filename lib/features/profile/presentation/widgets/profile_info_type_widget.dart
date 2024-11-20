import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';

class ProfileInfoTypeWidget extends StatelessWidget {
  final String infoName;
  final bool isVerified;
  final VoidCallback onTap;

  const ProfileInfoTypeWidget({
    super.key,
    required this.infoName,
    this.isVerified = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        height: 72,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 160,
              child: Flexible(
                child: Text(
                  infoName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 88,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isVerified
                        ? const Color(0xff88B778)
                        : const Color(0xff555555),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      isVerified ? 'Verified' : 'Unverified',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const Gap(width: 8),
                const Icon(
                  Icons.chevron_right_sharp,
                  size: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
