import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class ReactSandboxPage extends StatelessWidget {
  const ReactSandboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const Scaffold(
        body: Center(child: Text('This experiment is only supported on web.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('React inside Flutter')),
      body: Center(
        child: SizedBox(
          width: 600,
          height: 400,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: HtmlElementView.fromTagName(
                tagName: 'react-sandbox',
                onElementCreated: (element) {
                  final htmlElement = element as web.HTMLElement;

                  htmlElement.setAttribute('initial-value', '10');
                  htmlElement.style
                    ..width = '100%'
                    ..height = '100%'
                    ..display = 'block';
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
