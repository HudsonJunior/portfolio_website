import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scene/scene.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';
import 'package:vector_math/vector_math.dart' as vm;

/// Owns the Flutter Scene resources used to render the animated Dash model.
class DashSceneView extends StatefulWidget {
  const DashSceneView({super.key});

  @override
  State<DashSceneView> createState() => _DashSceneViewState();
}

class _DashSceneViewState extends State<DashSceneView> {
  static const _modelPath = 'assets/models/dash/dash_production_v2.glb';

  final Scene _scene = Scene();
  final ResourceGroup _resources = ResourceGroup();

  Node? _dash;
  AnimationClip? _runClip;
  PerspectiveCamera? _camera;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _resources.add(_loadDash()).ignore();
  }

  Future<void> _loadDash() async {
    try {
      final dash = await loadScene(_modelPath);
      if (!mounted) return;

      _scene.add(dash);

      if (kDebugMode) {
        for (final animation in dash.parsedAnimations) {
          debugPrint('Dash animation: ${animation.name}');
        }
      }

      final runAnimation = dash.findAnimationByName('Run');
      if (runAnimation == null) {
        final available = dash.parsedAnimations
            .map((animation) => animation.name)
            .join(', ');
        throw StateError(
          'The Dash model does not contain a Run animation. '
          'Available animations: ${available.isEmpty ? 'none' : available}.',
        );
      }

      final runClip = dash.createAnimationClip(runAnimation)
        ..loop = true
        ..play();

      final bounds = dash.combinedWorldBounds;
      final camera = bounds == null
          ? PerspectiveCamera(
              position: vm.Vector3(0, 1.2, -4),
              target: vm.Vector3(0, 1, 0),
            )
          : PerspectiveCamera.framing(bounds, margin: 1.3);

      if (bounds == null && kDebugMode) {
        debugPrint(
          'Dash has no combined world bounds; using the fallback camera.',
        );
      }

      _dash = dash;
      _runClip = runClip;
      setState(() => _camera = camera);
    } catch (error, stackTrace) {
      if (mounted) {
        setState(() => _error = error);
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  void dispose() {
    final dash = _dash;
    final runClip = _runClip;
    if (dash != null && runClip != null) {
      runClip.stop();
      dash.removeAnimationClip(runClip);
    }
    if (dash != null) {
      _scene.remove(dash);
    }

    // A ResourceGroup must not be disposed while an in-flight load can still
    // update its progress notifier.
    _resources.ready.whenComplete(_resources.dispose);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = _error;
    if (error != null) {
      return _SceneError(error: error);
    }

    return SceneView(
      _scene,
      camera: _camera,
      loading: _resources,
      warmUp: true,
      revealMinDuration: const Duration(milliseconds: 250),
      loadingBuilder: (context, progress) {
        return _SceneLoading(progress: progress);
      },
    );
  }
}

class _SceneLoading extends StatelessWidget {
  final double progress;

  const _SceneLoading({required this.progress});

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.accentLight),
          const SizedBox(height: 16),
          Text(
            'LOADING DASH · $percent%',
            style: AppTextStyles.mono(
              fontSize: 11,
              color: AppColors.textMuted,
              letterSpacing: 0.06 * 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _SceneError extends StatelessWidget {
  final Object error;

  const _SceneError({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.red,
              size: 38,
            ),
            const SizedBox(height: 14),
            Text(
              'Dash could not be loaded',
              style: AppTextStyles.spaceGrotesk(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: AppTextStyles.manrope(
                fontSize: 13,
                color: AppColors.textMuted,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
