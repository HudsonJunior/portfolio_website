enum ExperimentKind { motionLab, flutterScene, reactComponent }

class Experiment {
  final ExperimentKind kind;
  final String slug;
  final String title;
  final String summary;
  final String status;
  final List<String> tags;

  const Experiment({
    required this.kind,
    required this.slug,
    required this.title,
    required this.summary,
    required this.status,
    required this.tags,
  });
}

const kMotionLabExperiment = Experiment(
  kind: ExperimentKind.motionLab,
  slug: 'motion-lab',
  title: 'Flutter Motion Lab',
  summary:
      'Tune duration and easing, then send a widget across the stage to feel '
      'how each animation curve behaves.',
  status: 'Live experiment',
  tags: ['Animation', 'Curves', 'Interaction'],
);

const kFlutterSceneExperiment = Experiment(
  kind: ExperimentKind.flutterScene,
  slug: 'flutter-scene',
  title: 'Flutter Scene',
  summary:
      'Render Dash from a preprocessed GLB and automatically play its Run '
      'animation inside this Flutter Web app.',
  status: 'Experimental',
  tags: ['Flutter Scene', '3D', 'GLB'],
);

const kReactComponentExperiment = Experiment(
  kind: ExperimentKind.reactComponent,
  slug: 'react-component',
  title: 'React Component',
  summary: 'Render a React component inside a Flutter Web app.',
  status: 'Experimental',
  tags: ['React', 'Flutter', 'Web'],
);

const kExperiments = <Experiment>[
  kMotionLabExperiment,
  kFlutterSceneExperiment,
  kReactComponentExperiment,
];

Experiment? experimentBySlug(String slug) {
  for (final experiment in kExperiments) {
    if (experiment.slug == slug) return experiment;
  }
  return null;
}
