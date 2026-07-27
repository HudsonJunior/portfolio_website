enum ExperimentKind { motionLab }

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

const kExperiments = <Experiment>[kMotionLabExperiment];

Experiment? experimentBySlug(String slug) {
  for (final experiment in kExperiments) {
    if (experiment.slug == slug) return experiment;
  }
  return null;
}
