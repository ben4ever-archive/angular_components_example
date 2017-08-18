import 'dart:async';

import 'package:pageloader/objects.dart';

class MaterialSelectDemoPO {
  @ByCss('material-dropdown-select .button-text')
  PageLoaderElement _dropdown;

  @ByTagName('material-select-dropdown-item')
  List<PageLoaderElement> _dropdownItems;

  Future<Null> clickDropdown() => _dropdown.click();

  Future<String> get dropdownLabel => _dropdown.visibleText;

  int get dropdownLength => _dropdownItems.length;

  Future<Null> clickDropdownItem(int idx) => _dropdownItems[idx].click();
}
