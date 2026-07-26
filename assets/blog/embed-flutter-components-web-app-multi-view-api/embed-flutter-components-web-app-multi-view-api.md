This post extends the official [Flutter docs on embedding Flutter in web applications](https://docs.flutter.dev/platform-integration/web/embedding-flutter-web). We'll walk you through the process of embedding Flutter into an existing web app and dive deeper into the sections that need more practical detail.

Flutter is a great fit for mobile: shared business logic, consistent UI, [one codebase for iOS and Android](https://verygood.ventures/blog/benefits-of-flutter-for-cross-platform-app-development/). But what happens when your users also live on the web, in an application your company has been shipping for years?

Rewriting it in Flutter isn't realistic. What you need is a way to embed Flutter components into specific parts of that existing app without replacing the framework already in use. This is the web analog of the well-understood "add-to-app" pattern on mobile, and it's the foundation of Flutter web embedding into existing applications.

This post covers how to use Flutter's Multi-View Web API to embed multiple Flutter components into a host web application — whether that host is React, Angular, Vue, or plain HTML — and how to use Dart's JS interop to handle two-way communication between them. We'll walk through the setup, the architecture, and the patterns that matter in practice.

## The Problem Space

"Embed Flutter in a web page" sounds straightforward. It's not.

By default, a Flutter web app takes over the entire browser viewport: it renders into a `<canvas>` and owns everything inside it. There's no built-in way to embed a widget selectively inside a `<div>` alongside existing HTML. That's not how Flutter web was originally designed.

The workaround most people reach for first is iframes: host each Flutter component in its own iframe, size it to fit, done. This works for isolated, read-only content, but breaks down once you need runtime interaction. Cross-iframe communication relies on `postMessage`, which is unstructured, stringly-typed, and offers no ordering guarantees. You also lose access to the parent page's auth context, and each iframe runs its own Flutter engine instance, adding memory overhead with every component you add.

What's needed is for Flutter components to behave as first-class parts of the host page: sharing the same runtime context, communicating through a type-safe API, and running off a single engine instance regardless of how many components are present. The Multi-View API is the purpose-built alternative to iframe-based Flutter web embedding, and it's what makes this possible.

![Comparison of iframe-based Flutter web embedding versus Flutter Multi-View API embedded components on a single engine](assets/blog/embed-flutter-components-web-app-multi-view-api/the_problem_space.png)

## Architecture Overview

The setup involves three moving parts: the host web application, the Flutter web app running in embedded mode, and the JS/Dart interop layer connecting them.

The host page loads the Flutter engine once via `flutter_bootstrap.js` with `multiViewEnabled: true`. From that point, the host controls how many Flutter components appear and where: each is mounted into a regular HTML element (typically a `<div>`) using `app.addView()`. One Flutter engine instance powers all of them — a single instance serving multiple components on the same page.

```
Host Web App
├── <div id="component-a">   → Flutter View 1
├── <div id="component-b">   → Flutter View 2
└── Native web content       → Framework-managed
         ↕ dart:js_interop
   Flutter Engine (single instance)
   ├── View 1: ComponentAApp
   └── View 2: ComponentBApp
```

On the Flutter side, the app uses `runWidget` (not `runApp`) with a `MultiViewApp` wrapper that listens for view additions and removals via `didChangeMetrics`. It renders the appropriate widget into each view based on its `viewId` or `initialData`.

From the [Flutter docs](https://docs.flutter.dev/platform-integration/web/embedding-flutter-web#replace-runapp-by-runwidget-in-dart):

> Flutter's `runApp` function assumes that there's at least one view available to render into (the `implicitView`), however in Flutter web's multi-view mode, the `implicitView` doesn't exist anymore, so `runApp` will start failing with `Unexpected null value` errors.
>
> In multi-view mode, your `main.dart` must call the `runWidget` function instead. It doesn't require an `implicitView`, and will only render into the views that have been explicitly added into your app.

![Three-layer Flutter web embedding architecture: host web app, dart:js_interop bridge, and single Flutter engine serving multiple views](assets/blog/embed-flutter-components-web-app-multi-view-api/architecture_overview.png)

Communication between Flutter and the host is handled through `dart:js_interop`: Dart exposes functions to JavaScript, and JavaScript exposes functions or objects that Dart can call directly. This architecture reflects the [layered Flutter architecture](https://verygood.ventures/blog/very-good-flutter-architecture/) we use across mobile and web — clean separation between rendering, business logic, and integration boundaries.

## Full-Page Mode vs. Flutter Multi-View Mode

Before getting into setup, it's worth understanding how the two Flutter web embedding modes differ.

**Full-page mode** is the default: Flutter takes over the entire browser viewport and renders into a top-level canvas. This is what you get from a standard Flutter web project, and it's the recommended approach when embedding via iframe — letting Flutter own the iframe while the host page controls sizing and positioning.

**Multi-view (embedded) mode** is what enables selective embedding. In this mode, Flutter starts up but doesn't render anything until the host page explicitly adds a view. Views are attached to specific DOM elements, and the host can add or remove them at any time. There's no `implicitView`: Flutter only renders where it's told to.

The key differences in practice:

- In full-page mode you use `runApp`; in multi-view mode you use `runWidget`.
- In multi-view mode, Flutter notifies your app of view additions and removals via `didChangeMetrics`, and the live view list is available through `WidgetsBinding.instance.platformDispatcher.views`.
- Each view gets a `viewId` and an optional `initialData` payload passed from JS at mount time — both are available in Dart to decide what to render.

Enabling multi-view mode requires a single flag in `flutter_bootstrap.js` (see the official [Flutter web app initialization](https://docs.flutter.dev/platform-integration/web/initialization) docs for the full engine initializer API):

```js
_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    let engine = await engineInitializer.initializeEngine({
      multiViewEnabled: true,
    });
    let app = await engine.runApp();
    // expose `app` to the rest of your JS
  },
});
```

Once the engine is running, [adding a Flutter component to the page](https://docs.flutter.dev/platform-integration/web/embedding-flutter-web) is a single call:

```js
const viewId = app.addView({
  hostElement: document.querySelector("#image-gallery"),
  initialData: { productId: "123" },
});
```

Removing it is equally straightforward:

```js
app.removeView(viewId);
```

On the Dart side, view lifecycle is handled through `WidgetsBindingObserver`. The Flutter team provides a reference `MultiViewApp` widget in the [Multi View Playground repo](https://github.com/goderbauer/mvp) that handles this cleanly — a solid starting point rather than building the observer pattern from scratch.

## Embedding Multiple Components

With the engine in multi-view mode, the question becomes: how do you structure the Flutter app to serve multiple distinct components, each mounted into a different DOM element? The architecture below is one practical approach, applying [Flutter architecture best practices](https://verygood.ventures/blog/very-good-flutter-architecture/) to the embedding scenario.

### One Flutter app, multiple entry points

A single Flutter web build hosts all your components. There's no separate build per component — one `flutter_bootstrap.js`, one engine instance, one bundle download. Components are differentiated at runtime based on the `viewId` or `initialData` of the view being rendered.

The `MultiViewApp`'s `viewBuilder` callback handles that routing. Each time a view is added, `viewBuilder` is called with the `BuildContext` of that view, and you use `initialData` to decide which component to render:

```dart
runWidget(
  MultiViewApp(
    viewBuilder: (BuildContext context) {
      final viewId = View.of(context).viewId;
      final config = ui_web.views.getInitialData(viewId) as ViewConfig;

      return switch (config.component) {
        'chart'  => const ChartApp(),
        'picker' => const PickerApp(),
        _        => const SizedBox.shrink(),
      };
    },
  ),
);
```

The host passes the component identifier when adding each view:

```js
app.addView({
  hostElement: document.querySelector("#chart"),
  initialData: { component: "chart" },
});

app.addView({
  hostElement: document.querySelector("#picker"),
  initialData: { component: "picker" },
});
```

### Structuring the Flutter project

Since all components live in the same Flutter app, keep each in its own subtree with a clear root widget. Shared code — models, repositories, services — lives in a common layer that both components import.

```
lib/
  main.dart              # runWidget + view routing
  components/
    chart/
      chart_app.dart
      chart_controller.dart
    picker/
      picker_app.dart
      picker_controller.dart
  shared/
    models/
    repositories/
    services/
```

Each component's root widget handles its own state and lifecycle independently. They don't share widget state with each other: if View 1 needs to communicate with View 2, that communication goes through the host page (Flutter → host → Flutter), or through a [shared service layer](https://verygood.ventures/blog/very-good-flutter-architecture/) that both views reference.

### On the host side

The host is responsible for placing the container elements, loading the Flutter engine, and calling `addView` for each component at the right time. This happens inside `onEntrypointLoaded`, once `runApp()` has returned the `app` object:

```js
// flutter_bootstrap.js
_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    let engine = await engineInitializer.initializeEngine({
      multiViewEnabled: true,
    });
    let app = await engine.runApp();

    app.addView({
      hostElement: document.getElementById("chart"),
      initialData: { component: "chart" },
    });

    app.addView({
      hostElement: document.getElementById("picker"),
      initialData: { component: "picker" },
    });
  },
});
```

If `addView` needs to happen later — for example, when the user navigates to a specific page — store the `app` reference where the rest of your JS can reach it and call `addView` on demand.

## Two-Way Communication with Dart JS Interop

Mounting Flutter views into DOM elements is only half the job. The challenge is getting Flutter and the host page to communicate at runtime without losing type safety on either side.

The modern answer is [`dart:js_interop`](https://dart.dev/interop/js-interop), introduced in Dart 3.3. It replaces the older `package:js` and `dart:js` libraries and, importantly, is Wasm-compatible. Wasm compatibility matters for production longevity: as Flutter's Wasm support stabilizes, code written against `dart:js_interop` carries forward without rework. If you're on an older interop approach, migrate.

### Host → Flutter: calling Dart from JavaScript

Passing data at mount time via `initialData` covers initial setup. For runtime communication — when the host needs to update a component after mount — you need to expose a Dart function that JS can call.

Use `Function.toJS` to wrap a Dart function, then make it available on the global scope (or attach it to a JS object) via an interop setter:

```dart
import 'dart:js_interop';

@JS()
external set onProductSelected(JSFunction value);

void handleProductSelected(JSString productId) {
  // update component state
  myController.loadProduct(productId.toDart);
}

void main() {
  // Expose the Dart handler to JS before the host calls it
  onProductSelected = handleProductSelected.toJS;
  runWidget(...);
}
```

The host can then call it like any JS function:

```js
window.onProductSelected("product-123");
```

For exposing an entire class interface (useful when a component has multiple callable methods), use the [`@JSExport` annotation](https://dart.dev/blog/new-in-dart-3-3-extension-types-javascript-interop-and-more) with `createJSInteropWrapper`. The real power comes from making that class a `ChangeNotifier`: both Dart and JS then hold a reference to the same in-memory instance, so updates from either side reflect immediately without manual synchronization.

```dart
import 'dart:js_interop';
import 'package:flutter/foundation.dart';

@JSExport()
class ChartController extends ChangeNotifier {
  List<double> _data = [];
  String _title = '';
  JSFunction? _onTitleChanged;

  List<double> get data => _data;
  String get title => _title;

  // JS calls this to push new data — notifyListeners() rebuilds the widget
  void updateData(JSArray<JSNumber> points) {
    _data = points.toDart.map((p) => p.toDartDouble).toList();
    notifyListeners();
  }

  // Dart calls this after a user interaction — also notifies JS via callback
  void setTitle(String value) {
    _title = value;
    notifyListeners();
    _onTitleChanged?.callAsFunction(null, value.toJS);
  }

  // JS registers a callback to react to Dart-side state changes
  set onTitleChanged(JSFunction callback) => _onTitleChanged = callback;
}
```

Rather than placing the controller on `window`, deliver it through a ready callback passed in `initialData`. This keeps the controller scoped to the host element, avoids global namespace pollution, and ensures JS only gets the reference once the view has actually initialized:

```dart
extension type ViewConfig._(JSObject _) implements JSObject {
  external String get component;
  external JSFunction? get onControllerReady;
}
```

In `viewBuilder`, create the controller, wrap it, and hand it back to JS immediately via the callback:

```dart
Widget _buildView(BuildContext context) {
  final viewId = View.of(context).viewId;
  final controller = ChartController();
  final config = _parseConfig(viewId); // see safe-parsing note below

  // Deliver the same Dart instance to JS — scoped to this view
  final jsController = createJSInteropWrapper(controller);
  config?.onControllerReady?.callAsFunction(null, jsController);

  return ListenableBuilder(
    listenable: controller,
    builder: (context, _) => ChartApp(controller: controller),
  );
}
```

On the JS side, the host passes the callback when adding the view:

```js
const hostElement = document.querySelector("#chart");

app.addView({
  hostElement,
  initialData: {
    component: "chart",
    onControllerReady: (controller) => {
      // Store on the element — no global, no race condition
      hostElement.controller = controller;
    },
  },
});

// Later, interact with the controller
hostElement.controller.updateData([1.2, 3.4, 5.6]);

// Listen to Dart-side changes
hostElement.controller.onTitleChanged = (newTitle) => {
  document.querySelector("#chart-label").textContent = newTitle;
};
```

Because both sides reference the same object, there's no diffing, no message passing, and no risk of the two sides falling out of sync. JS calls a method, Dart rebuilds. Dart updates state, JS gets notified. The `ChangeNotifier` is the contract.

### Flutter → Host: calling JavaScript from Dart

For the reverse direction — Flutter notifying the host of user interactions — define an extension type for the JS callback you expect the host to provide, then call it from Dart.

The cleanest contract is to accept a JS callback at mount time via `initialData`:

```dart
import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

// Each component defines its own config shape
extension type PickerConfig._(JSObject _) implements JSObject {
  external JSFunction get onVariantSelected;
}

// In your widget:
final config = ui_web.views.getInitialData(viewId) as PickerConfig;

void notifyHost(String variantId) {
  config.onVariantSelected.callAsFunction(null, variantId.toJS);
}
```

On the JS side, the host passes the callback when adding the view:

```js
app.addView({
  hostElement: document.querySelector("#variant-picker"),
  initialData: {
    onVariantSelected: (variantId) => {
      // update host UI
      updatePrice(variantId);
    },
  },
});
```

This keeps the communication contract explicit and co-located with the `addView` call, which makes the integration easier to reason about as it grows.

### A note on type conversions

`dart:js_interop` doesn't automatically convert between Dart and JS types. Strings cross the boundary as `JSString` (use `.toDart` going in, `.toJS` going out), and collections follow the same pattern with `JSArray` and `JSObject`. The explicitness makes interop boundaries visible and lets the compiler catch type mismatches early.

### Safe parsing of JS data

JS is untyped, so when `initialData` arrives in Dart it's effectively a `JSObject` — a bag of keys with no compile-time shape guarantee. Casting it directly to an extension type with typed getters (`external String get component`) works if the host always passes the right structure, but a missing or mistyped field will throw at runtime and can take down the entire view.

Don't reach for `dartify()` either. It turns the whole object into a `Map` and pushes validation into a `fromJson` path that is easy to drift from the real interop boundary. The safer pattern is field-by-field: a Dart model you own, an extension type that exposes raw `JSAny?` properties, small typed readers that validate each value, and a mapper that assembles the model.

**1. Define the Dart model** — the shape your widgets actually consume:

```dart
class ViewConfig {
  const ViewConfig({
    required this.component,
    this.productId,
    this.onControllerReady,
  });

  final String component;
  final String? productId;
  final JSFunction? onControllerReady;
}
```

**2. Mirror it with an extension type** — getters stay as `JSAny?` so nothing is coerced until you validate it:

```dart
extension type ViewConfigJs._(JSObject _) implements JSObject {
  external JSAny? get component;
  external JSAny? get productId;
  external JSAny? get onControllerReady;
}
```

**3. Add typed readers** — each helper checks nullability and runtime type, then converts with `.toDart`:

```dart
class EmbedParseException implements Exception {
  EmbedParseException(this.message);
  final String message;

  @override
  String toString() => message;
}

String? readOptionalString(
  JSAny? value, {
  required String field,
}) {
  if (value == null) return null;
  if (value.isA<JSString>()) {
    return (value as JSString).toDart;
  }
  throw EmbedParseException('$field must be a string');
}

String readRequiredString(
  JSAny? value, {
  required String field,
}) {
  final result = readOptionalString(value, field: field);
  if (result == null) {
    throw EmbedParseException('$field is required');
  }
  return result;
}
```

**4. Map JS → Dart** — the mapper is the only place that knows which fields exist and how they convert:

```dart
ViewConfig parseViewConfigFromJs(ViewConfigJs js) {
  return ViewConfig(
    component: readRequiredString(js.component, field: 'component'),
    productId: readOptionalString(js.productId, field: 'productId'),
    onControllerReady: js.onControllerReady == null
        ? null
        : js.onControllerReady as JSFunction,
  );
}

ViewConfig? parseConfig(int viewId) {
  try {
    final raw = ui_web.views.getInitialData(viewId) as JSObject;
    return parseViewConfigFromJs(raw as ViewConfigJs);
  } on EmbedParseException catch (e) {
    // Route to view-wise error handling (see next section)
    return null;
  }
}
```

Each field fails with a clear message (`productId must be a string`) instead of a generic cast error deep in a recursive conversion. Required vs optional is explicit at the call site, nested objects get the same treatment with a dedicated parse function, and the `catch` block keeps a bad payload from reaching the engine.

## State Management and Lifecycle Across Views

### State is per-view

Each Flutter view gets its own independent widget tree. There's no shared widget state between views: if View 1 needs to communicate with View 2, that communication goes through the host page (Flutter → host → Flutter), or through a shared Dart singleton or service that both views reference.

The shared Dart layer is often the right call when views share domain logic — for example, two components that both care about the currently selected product. A simple `ChangeNotifier` or a [BLoC living outside the widget tree](https://verygood.ventures/blog/why-we-use-flutter-bloc/), referenced by both views, works well and avoids unnecessary round-trips through JS.

### Reacting to view removal

When the host calls `app.removeView(viewId)`, Flutter receives a `didChangeMetrics` callback. The `MultiViewApp` pattern handles this by diffing the live view list against its internal map and removing the corresponding widget. Widgets that are removed follow the normal Flutter disposal flow: `dispose()` is called, subscriptions are cancelled, and resources are cleaned up.

One thing to be deliberate about: if your view holds resources tied to the Dart singleton layer — stream subscriptions, listeners on a shared service — make sure `dispose()` unregisters them. In a single-view app this is rarely an issue; with multiple views coming and going, leaked subscriptions add up.

### Error isolation

Errors in a multi-view setup fall into two distinct categories that need different handling strategies: app-wise errors that affect the Flutter engine as a whole, and view-wise errors that are scoped to a specific mounted component.

**App-wise errors** are thrown by the Flutter engine itself — build and layout exceptions caught by `FlutterError.onError`, and unhandled async errors that surface via `runZonedGuarded`. If these go unhandled, they can affect all views simultaneously. The right response is to intercept them at startup and notify the host via a global JS callback:

```dart
@JS('onFlutterEngineError')
external JSFunction? get _jsEngineErrorCallback;

void _notifyEngineError(String message) {
  _jsEngineErrorCallback?.callAsFunction(null, message.toJS);
}

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    _notifyEngineError(details.exceptionAsString());
  };

  runZonedGuarded(() {
    runWidget(MultiViewApp(viewBuilder: _buildView));
  }, (error, stack) {
    _notifyEngineError(error.toString());
  });
}
```

The host registers a handler before the engine loads:

```js
window.onFlutterEngineError = (message) => {
  // Show a full-page fallback or forward to error monitoring
  showGlobalErrorBanner(message);
};
```

**View-wise errors** are scoped to a single component — the most common case being invalid or missing data in `initialData`. These should not take down the full engine; they should surface to the host as a per-view signal. A `ViewController` class exposed via `@JSExport` gives the host a per-view handle to subscribe to:

```dart
@JSExport()
class ViewController {
  JSFunction? _onError;

  set onError(JSFunction callback) => _onError = callback;

  void reportError(String message) {
    _onError?.callAsFunction(null, message.toJS);
  }
}
```

Wire it into `viewBuilder` alongside the safe-parsing pattern from the previous section:

```dart
Widget _buildView(BuildContext context) {
  final viewId = View.of(context).viewId;
  final viewController = ViewController();
  globalContext['viewController_$viewId'] = createJSInteropWrapper(viewController);

  final config = _parseConfig(viewId, viewController);
  if (config == null) return const SizedBox.shrink();

  return ChartApp(config: config);
}

ViewConfig? _parseConfig(int viewId, ViewController controller) {
  try {
    final raw = ui_web.views.getInitialData(viewId) as JSObject;
    return parseViewConfigFromJs(raw as ViewConfigJs);
  } on EmbedParseException catch (e) {
    controller.reportError('Invalid view config: $e');
    return null;
  }
}
```

On the JS side, the host subscribes after calling `addView`:

```js
const viewId = app.addView({
  hostElement: document.querySelector("#chart"),
  initialData: { component: "chart", productId: "123" },
});

window[`viewController_${viewId}`].onError = (message) => {
  console.error(`View ${viewId} failed:`, message);
  document.querySelector("#chart").innerHTML = "<p>Component unavailable</p>";
};
```

The result is a clean separation: engine-level failures escalate globally, view-level failures stay contained and give the host the information it needs to degrade gracefully at the right scope.

### Synchronizing state with the host

The main thing to avoid is letting Flutter's internal state drift from what the host believes to be true. If Flutter updates its state in response to a user action and doesn't notify the host, you'll eventually have inconsistencies: the host shows stale data, or sends a conflicting update.

The practical rule: whenever Flutter changes something the host cares about, fire the relevant JS callback immediately. The host owns cross-boundary state; Flutter owns its own rendering and interaction logic.

## Data Fetching and Code Sharing Between Mobile and Web

If your Flutter mobile app already has [repositories, services, and models](https://verygood.ventures/blog/very-good-flutter-architecture/), the embedded web components can use them directly. This is one of the strongest practical arguments for the architecture — the same business logic that powers your iOS and Android apps can drive embedded web components without duplication.

![Flutter mobile app and embedded Flutter web component sharing the same Dart business logic layer — repositories, models, and services](assets/blog/embed-flutter-components-web-app-multi-view-api/data_fetching_and_code_sharing.png)

### What actually gets shared

The shareable layer is anything that doesn't touch platform-specific APIs: domain models, business logic, validation, repository interfaces, and any networking code built on `dio` or `http`. This covers the vast majority of application logic.

What can't be shared without adaptation is anything platform-specific: file system access, secure storage, native auth flows, or code that imports `dart:io` (which isn't available on web). For these, use conditional imports to swap in a web-compatible implementation at compile time:

```dart
// data_source.dart
export 'data_source_stub.dart'
    if (dart.library.io) 'data_source_mobile.dart'
    if (dart.library.js_interop) 'data_source_web.dart';
```

Each platform file implements the same abstract interface, so the rest of the codebase stays untouched. This is more reliable than `kIsWeb` runtime checks — the compiler resolves it at build time and only includes what's needed. Note: use `dart.library.js_interop` as the web condition (not `dart.library.html`, which is [deprecated in favor of `package:web`](https://dart.dev/interop/js-interop/package-web)).

### Data fetching strategies

For embedded components, there are two reasonable approaches depending on your setup:

**Flutter fetches directly.** The component owns its data fetching using the same repository it uses on mobile. This keeps the component self-contained and avoids duplicating API logic in the host. The trade-off is that auth tokens and session context need to be accessible from Dart — typically passed in via `initialData` or stored in a shared singleton that's hydrated from JS at startup.

**Host passes data in.** The host page fetches data as it normally would and passes it to Flutter via `initialData` or a runtime callback. Flutter purely handles presentation. This is simpler when the host already has the data, but it means the two layers can drift if data shapes change independently.

In practice, a hybrid works best: the host passes session and auth context at mount time, and Flutter fetches its own domain data using that context. This mirrors how the mobile app works and keeps the shared repository layer doing its job.

## Production Considerations

These considerations apply across the spectrum from prototypes to production Flutter web deployments — bundle size, caching, renderer choice, and debugging each surface differently at scale, and each is worth getting right before shipping.

### Bundle size and initial load

A Flutter web app — even a small one — carries a [significant initial download](https://verygood.ventures/blog/google-io-2026/). As of Flutter 3.x, a minimal [CanvasKit bundle](https://docs.flutter.dev/platform-integration/web/renderers) is around 1.5–2 MB compressed; HTML renderer builds are lighter but come with rendering trade-offs. When embedding into an existing web app, this cost is paid once on first load and cached, so be upfront with stakeholders about it.

If your components aren't always needed, defer the Flutter engine load until the user navigates to a page that uses them. Don't load `flutter_bootstrap.js` on pages where no Flutter view will be mounted.

For apps with many components, Dart's [deferred imports](https://docs.flutter.dev/perf/deferred-components) (`import 'package:...' deferred as x`) let you split component code into separate chunks loaded on demand. This keeps the initial bundle tight and loads heavier components only when `addView` is called for them.

### Caching and deployment

Flutter's build output includes a main bundle and several `.part.js` chunks. An important production gotcha: if a user's browser caches old `.part.js` files while receiving a new `main.dart.js` after a deploy, the app will throw `DeferredLoadException` at runtime due to API mismatches between chunks. Solve this with content-addressed filenames (Flutter's build system does this by default) and ensure your CDN or server doesn't serve stale parts after a deploy.

### Renderer choice

Use CanvasKit. It produces pixel-perfect output consistent with mobile, which is the point of this architecture. The HTML renderer is lighter but can differ visually. Set it explicitly in `flutter_bootstrap.js` rather than relying on automatic selection.

### Debugging

Browser DevTools will show the Flutter engine as a single canvas element, which doesn't help for inspecting widget trees. Use Flutter DevTools — it works for web just as it does for mobile — and connect to the running app via the VM service URL. For JS interop issues specifically, `dart:developer`'s `log` function outputs to the browser console and is useful for tracing the boundary between Dart and JS.

## Takeaways

**Use `initialData` as your primary data contract.** It's the cleanest way to pass configuration and callbacks to a component at mount time, and it keeps the integration readable — the `addView` call tells you everything about how that component is set up.

**`dart:js_interop` is the right interop layer.** Avoid `package:js` and `dart:js` for new work. Extension types give you type safety across the Dart/JS boundary, and the approach is Wasm-compatible if you ever move in that direction.

**Export a `ChangeNotifier`, not just functions.** Wrapping a `ChangeNotifier` subclass with `createJSInteropWrapper` gives both Dart and JS a reference to the same instance. JS calls a method, Dart's widget rebuilds. Dart updates state, JS gets notified via a registered callback. No diffing, no message passing, no sync bugs.

**Parse JS data defensively.** Define a Dart model, mirror it with an extension type whose fields are `JSAny?`, then validate and convert field-by-field with typed readers before mapping into your model. Direct casts against typed extension getters will throw if the host passes an unexpected shape; the field-by-field path gives you clear errors you can catch and handle before they reach the engine.

**Keep the Flutter app ignorant of the host framework.** The embedded Flutter app should not know whether it's living inside an Angular app, a React app, or a static HTML page. The contract is JS — keep it that way, and the integration stays portable.

**One engine, as many views as you need.** The single engine instance is a meaningful advantage over iframes. It means shared state across components is a first-class option via Dart singletons, and memory cost doesn't scale linearly with the number of components.

**The pattern earns its complexity when you have shared mobile logic.** If your Flutter web components are isolated one-offs with no mobile counterpart, a different approach might be simpler. But if you're running the same business logic on iOS, Android, and now web — with components that benefit from Flutter's rendering — Flutter web embedding via the Multi-View API pays its upfront cost many times over.
