@Tags(const ['aot'])
@TestOn('browser')

import 'dart:async';
import 'dart:html';

import 'package:angular_components/angular_components.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular/angular.dart';
import 'package:test/test.dart';

import 'package:angular_components_example/src/material_select_demo/material_select_demo.dart';
import 'material_select_demo_po.dart';

@AngularEntrypoint()
void main() {
  NgTestFixture<ParentComponent> fixture;
  MaterialSelectDemoPO po;

  tearDown(disposeAnyRunningTest);

  setUp(() async {
    final testBed = new NgTestBed<ParentComponent>();
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

HtmlElement getOverlayContainerParent(Element parent) => parent;

@Component(
  selector: 'parent',
  template: '<material-select-demo></material-select-demo>',
  directives: const [
    MaterialSelectDemoComponent,
  ],
  providers: const [
    materialProviders,
    const Provider(overlayContainerParent,
        useFactory: getOverlayContainerParent, deps: const [Element]),
  ],
)
class ParentComponent {}
