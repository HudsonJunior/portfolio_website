class ExperienceModel {
  final String number;
  final String company;
  final String role;
  final String period;
  final bool isCurrent;
  final List<String> points;
  final List<String> stack;

  const ExperienceModel({
    required this.number,
    required this.company,
    required this.role,
    required this.period,
    required this.isCurrent,
    required this.points,
    required this.stack,
  });
}

const kExperiences = [
  ExperienceModel(
    number: '01',
    company: 'Very Good Ventures',
    role: 'Senior Engineer I',
    period: 'Jul 2025 — Present',
    isCurrent: true,
    points: [
      'Joining a world-class Flutter consultancy known for engineering excellence and open-source impact.',
      'Building high-quality Flutter applications for clients across multiple industries.',
      'Upholding VGV\'s standards of clean architecture, testing, and code quality.',
    ],
    stack: ['Flutter', 'Dart', 'Architecture'],
  ),
  ExperienceModel(
    number: '02',
    company: 'MGM Resorts',
    role: 'Senior Mobile Engineer',
    period: 'Mar 2023 — Jun 2025',
    isCurrent: false,
    points: [
      "Contributed to one of the world's largest resort apps, focused on architecture and performance.",
      'Built solutions that improved code performance, maintainability, and readability.',
      'Led feature delivery with a focus on quality and architectural standards.',
      'Ran code reviews, upheld architecture integrity, and onboarded new developers.',
    ],
    stack: ['Flutter', 'Architecture', 'Performance'],
  ),
  ExperienceModel(
    number: '03',
    company: 'CourseKey',
    role: 'Mobile Engineer',
    period: 'Oct 2022 — Feb 2023',
    isCurrent: false,
    points: [
      'Led the architecture migration from Redux to Bloc, boosting performance and maintainability.',
      'Ensured high-quality code with rigorous testing and best practices.',
      'Collaborated with cross-functional teams to align mobile features with product strategy.',
    ],
    stack: ['Flutter', 'Bloc', 'Testing'],
  ),
  ExperienceModel(
    number: '04',
    company: 'AMcom',
    role: 'Mobile Engineer',
    period: 'May 2022 — Oct 2022',
    isCurrent: false,
    points: [
      'Contributed to a large-scale banking app with Flutter as part of the digital transformation team.',
      'Developed and maintained the design system, ensuring app-wide consistency and quality.',
      'Enhanced functionality and user experience through key initiatives.',
    ],
    stack: ['Flutter', 'Design System', 'Banking'],
  ),
  ExperienceModel(
    number: '05',
    company: 'EurekaLabs',
    role: 'Mobile Engineer',
    period: '2020 — 2022',
    isCurrent: false,
    points: [
      'Developed end-to-end mobile apps with Flutter, focusing on performance and responsiveness.',
      'Led code reviews and architecture planning to uphold clean code standards.',
      'Built native plugins in Swift and Kotlin to extend app capabilities.',
    ],
    stack: ['Flutter', 'Swift', 'Kotlin'],
  ),
  ExperienceModel(
    number: '06',
    company: 'InovaClick Software',
    role: 'Fullstack Engineer',
    period: '2019 — 2020',
    isCurrent: false,
    points: [
      'Built mobile projects with Android and Swift.',
      'Maintained web applications with ASP.NET, HTML, and JavaScript.',
      'Created Node.js APIs to support web and mobile functionality.',
    ],
    stack: ['Android', 'Swift', 'Node.js'],
  ),
];
