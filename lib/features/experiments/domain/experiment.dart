class Experiment {
  final String slug;
  final String title;
  final String summary;
  final String status;
  final List<String> tags;

  const Experiment({
    required this.slug,
    required this.title,
    required this.summary,
    required this.status,
    required this.tags,
  });
}

const kExperiments = <Experiment>[
  Experiment(
    slug: 'motion-lab',
    title: 'Flutter Motion Lab',
    summary:
        'Tune duration and easing, then send a widget across the stage to feel '
        'how each animation curve behaves.',
    status: 'LIVE EXPERIMENT',
    tags: ['Animation', 'Curves', 'Interaction'],
  ),
];

Experiment? experimentBySlug(String slug) {
  for (final experiment in kExperiments) {
    if (experiment.slug == slug) return experiment;
  }
  return null;
}
