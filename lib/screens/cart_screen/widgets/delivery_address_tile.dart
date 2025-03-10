import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';

class DeliveryAddressTileWidget extends StatelessWidget {
  const DeliveryAddressTileWidget(
      {required this.navigateToAddressScreen, super.key});

  final VoidCallback navigateToAddressScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateToAddressScreen,
      child: SizedBox(
        width: 335,
        height: 74,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 335,
                height: 74,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(
                      0xFFEFF0F2,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Positioned(
              left: 70,
              top: 17,
              child: SizedBox(
                width: 215,
                height: 41,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -1,
                      left: -1,
                      child: SizedBox(
                        width: 219,
                        child: Consumer(
                          builder: (_, WidgetRef ref, __) {
                            final user = ref.watch(loggedUserProvider);
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 114,
                                    child: Text(
                                      user == null
                                          ? 'Add address'
                                          : 'Contact data',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        height: 1.1,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    user?.state ?? '',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    user?.city ?? '',
                                    style: GoogleFonts.lato(
                                      color: const Color(0xFF7F808C),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 16,
              child: SizedBox.square(
                dimension: 42,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 43,
                        height: 43,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFFBF7F5,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Positioned(
                              left: 11,
                              top: 11,
                              child: Image.network(
                                height: 26,
                                width: 26,
                                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 305,
              top: 25,
              child: Image.network(
                width: 20,
                height: 20,
                'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a',
              ),
            )
          ],
        ),
      ),
    );
  }
}
