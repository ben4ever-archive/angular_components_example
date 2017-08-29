@Tags(const ['aot'])
@TestOn('browser')

import 'dart:async';
import 'dart:html';

import 'package:angular_components/angular_components.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular/angular.dart';
import 'package:pageloader/html.dart';
import 'package:test/test.dart';

import 'package:angular_components_example/src/material_select_demo/material_select_demo.dart';
import 'material_select_demo_po.dart';

PageLoader Function(
        Element el, NgTestFixture<MaterialSelectDemoComponent> fixture)
    _getCreatePageLoaderFunc(Element el) {
  return (_, fixture) => new HtmlPageLoader(el, executeSyncedFn: (fn) async {
        await fn();
        return fixture.update();
      });
}

@AngularEntrypoint()
void main() {
  NgTestFixture<MaterialSelectDemoComponent> fixture;
  MaterialSelectDemoPO po;

  tearDown(disposeAnyRunningTest);

  setUp(() async {
    var parentDiv = new DivElement(),
        hostDiv = new DivElement(),
        overlayContDiv = new DivElement();
    parentDiv.children..add(hostDiv)..add(overlayContDiv);
    final testBed = new NgTestBed<MaterialSelectDemoComponent>(host: hostDiv)
        .setPageLoader(_getCreatePageLoaderFunc(parentDiv))
        .addProviders([
      materialProviders,
      provide(overlayContainerParent, useValue: overlayContDiv),
    ]);
    fixture = await testBed.create();
    po = await fixture.resolvePageObject(MaterialSelectDemoPO);
    await fixture.update();
  });

  group('dropdown', () {
    test('should show "select language" label', () async {
      expect(await po.dropdownLabel, 'Select Language');
    });

    group('click dropdown', () {
      setUp(() async {
        await po.clickDropdown();
        // Wait until dropdown popup is fully opened.
        await new Future.delayed(const Duration(milliseconds: 500));
        po = await fixture.resolvePageObject(MaterialSelectDemoPO);
      });

      test('check length', () async {
        expect(po.dropdownLength, 4);
      });

      test('click dropdown item', () async {
        await po.clickDropdownItem(0);
        po = await fixture.resolvePageObject(MaterialSelectDemoPO);
        expect(await po.dropdownLabel, 'US English');
      });
    });
  });
}
