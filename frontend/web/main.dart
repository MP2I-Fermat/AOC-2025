// The entrypoint for the **client** environment.
//
// This file is compiled to javascript and executed in the browser.

// Client-specific jaspr import.
import 'package:jaspr/browser.dart';
// Imports the [App] component.
import 'package:frontend/app.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

void main() {
  // Attaches the [App] component to the <body> of the page.
  runApp(ProviderScope(child: App()));
}
