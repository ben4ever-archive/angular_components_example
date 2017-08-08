// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

HtmlElement getOverlayContainerParent(Document doc) =>
    doc.querySelector('#my-container');

@Component(
  selector: 'material-select-demo',
  styleUrls: const ['material_select_demo.css'],
  templateUrl: 'material_select_demo.html',
  directives: const [
    MaterialDropdownSelectComponent,
  ],
  providers: const [
    const Provider(overlayContainerParent,
        useFactory: getOverlayContainerParent, deps: const [Document]),
  ],
)
class MaterialSelectDemoComponent {
  static const List<Language> _languagesListLong = const <Language>[
    const Language('en-US', 'US English'),
    const Language('en-UK', 'UK English'),
    const Language('af', 'Afrikaans'),
    const Language('sq', 'Albanian'),
  ];

// Languages to choose from.
  SelectionOptions<Language> get languageOptionsLong =>
      new SelectionOptions<Language>.fromList(_languagesListLong);

// Single Selection Model.
  final SelectionModel<Language> singleSelectModel =
      new SelectionModel.withList();

// Label for the button for single selection.
  String get singleSelectLanguageLabel =>
      singleSelectModel.selectedValues.length > 0
          ? singleSelectModel.selectedValues.first.toString()
          : 'Select Language';

  String get singleSelectedLanguage =>
      singleSelectModel.selectedValues.isNotEmpty
          ? singleSelectModel.selectedValues.first.toString()
          : null;
}

class Language {
  final String code;
  final String label;

  const Language(this.code, this.label);

  @override
  String toString() => label;
}
