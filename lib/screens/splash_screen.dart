import 'package:flutter/material.dart';
import 'employee_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Background fade
  late Animation<double> _bgFade;

  // Logo circle scale + fade
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;

  // Rings pulse
  late Animation<double> _ring1Scale;
  late Animation<double> _ring1Fade;
  late Animation<double> _ring2Scale;
  late Animation<double> _ring2Fade;

  // Icon slide + fade
  late Animation<double> _iconFade;
  late Animation<Offset> _iconSlide;

  // Title slide + fade
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;

  // Subtitle fade
  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;

  // Shimmer shine on logo
  late Animation<double> _shimmer;

  // Screen exit fade
  late Animation<double> _exitFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _bgFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
    );

    _ring1Scale = Tween<double>(begin: 0.4, end: 1.6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.55, curve: Curves.easeOut),
      ),
    );
    _ring1Fade = Tween<double>(begin: 0.6, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.55, curve: Curves.easeOut),
      ),
    );

    _ring2Scale = Tween<double>(begin: 0.4, end: 1.6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.65, curve: Curves.easeOut),
      ),
    );
    _ring2Fade = Tween<double>(begin: 0.4, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.65, curve: Curves.easeOut),
      ),
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.45, curve: Curves.elasticOut),
      ),
    );
    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.1, 0.35, curve: Curves.easeIn),
    );

    _iconFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.5, curve: Curves.easeIn),
    );
    _iconSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.5, curve: Curves.easeOut),
      ),
    );

    _shimmer = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.7, curve: Curves.easeInOut),
      ),
    );

    _titleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.48, 0.65, curve: Curves.easeIn),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.48, 0.65, curve: Curves.easeOut),
      ),
    );

    _subtitleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.58, 0.75, curve: Curves.easeIn),
    );
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.58, 0.75, curve: Curves.easeOut),
      ),
    );

    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward().then((_) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const EmployeeListScreen(),
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          body: FadeTransition(
            opacity: _exitFade,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Gradient background
                FadeTransition(
                  opacity: _bgFade,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF4A148C),
                          Color(0xFF7B1FA2),
                          Color(0xFF9C27B0),
                          Color(0xFFCE93D8),
                        ],
                        stops: [0.0, 0.35, 0.65, 1.0],
                      ),
                    ),
                  ),
                ),

                // Decorative blurred circles
                Positioned(
                  top: -80,
                  right: -60,
                  child: FadeTransition(
                    opacity: _bgFade,
                    child: Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -100,
                  left: -80,
                  child: FadeTransition(
                    opacity: _bgFade,
                    child: Container(
                      width: 340,
                      height: 340,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                ),

                // Center content
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo with ripple rings
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ring 2 (outer)
                            FadeTransition(
                              opacity: _ring2Fade,
                              child: Transform.scale(
                                scale: _ring2Scale.value,
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.4),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Ring 1 (inner)
                            FadeTransition(
                              opacity: _ring1Fade,
                              child: Transform.scale(
                                scale: _ring1Scale.value,
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.6),
                                      width: 2.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Logo circle
                            FadeTransition(
                              opacity: _logoFade,
                              child: Transform.scale(
                                scale: _logoScale.value,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.25),
                                        blurRadius: 24,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 8),
                                      ),
                                      BoxShadow(
                                        color: Colors.purple.withValues(alpha: 0.3),
                                        blurRadius: 40,
                                        spreadRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Stack(
                                      children: [
                                        // Shimmer sweep
                                        Positioned.fill(
                                          child: ShaderMask(
                                            shaderCallback: (rect) {
                                              return LinearGradient(
                                                begin: Alignment(
                                                  _shimmer.value - 0.5,
                                                  -1,
                                                ),
                                                end: Alignment(
                                                  _shimmer.value + 0.5,
                                                  1,
                                                ),
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.white.withValues(alpha: 0.6),
                                                  Colors.transparent,
                                                ],
                                              ).createShader(rect);
                                            },
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        // Icon
                                        Center(
                                          child: FadeTransition(
                                            opacity: _iconFade,
                                            child: SlideTransition(
                                              position: _iconSlide,
                                              child: const Icon(
                                                Icons.groups_rounded,
                                                size: 64,
                                                color: Color(0xFF7B1FA2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 36),

                      // App title
                      FadeTransition(
                        opacity: _titleFade,
                        child: SlideTransition(
                          position: _titleSlide,
                          child: const Text(
                            'Employee List',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Subtitle
                      FadeTransition(
                        opacity: _subtitleFade,
                        child: SlideTransition(
                          position: _subtitleSlide,
                          child: Text(
                            'Manage your team with ease',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withValues(alpha: 0.8),
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom loading dots
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _subtitleFade,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        return AnimatedBuilder(
                          animation: _controller,
                          builder: (_, _) {
                            final t = (_controller.value - 0.72 - i * 0.04)
                                .clamp(0.0, 0.15) /
                                0.15;
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(
                                    alpha: 0.4 + 0.6 * t),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
