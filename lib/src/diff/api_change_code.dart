enum ApiChangeCode {
  /// interface removed
  ci01._('CI01', 'interface removed'),

  /// interface added
  ci02._('CI02', 'interface added'),

  /// interface renamed
  ci03._('CI03', 'interface renamed'),

  /// supertype added
  ci04._('CI04', 'supertype added'),

  /// supertype removed
  ci05._('CI05', 'supertype removed'),

  /// type parameters changed
  ci06._('CI06', 'type parameters changed'),

  /// type parameter added
  ci07._('CI07', 'type parameter added'),

  /// type parameter removed
  ci08._('CI08', 'type parameter removed'),

  /// deprecated status changed
  ci09._('CI09', 'deprecated status changed'),

  /// experimental status changed
  ci10._('CI10', 'experimental status changed'),

  /// sealed status changed
  ci11._('CI11', 'sealed status changed'),

  /// executable parameters removed
  ce01._('CE01', 'executable parameters removed'),

  /// executable parameters added
  ce02._('CE02', 'executable parameters added'),

  /// executable parameters renamed
  ce03._('CE03', 'executable parameters renamed'),

  /// executable parameters reordered
  ce04._('CE04', 'executable parameters reordered'),

  /// executable parameter requiredness changed

  ce05._('CE05', 'executable parameter requiredness changed'),

  /// executable parameter deprecated status changed
  ce06._('CE06', 'executable parameter deprecated status changed'),

  /// executable parameter named status changed
  ce07._('CE07', 'executable parameter named status changed'),

  /// executable parameter type changed
  ce08._('CE08', 'executable parameter type changed'),

  /// executable return type changed
  ce09._('CE09', 'executable return type changed'),

  /// executable removed
  ce10._('CE10', 'executable removed'),

  /// executable added
  ce11._('CE11', 'executable added'),

  /// executable renamed
  ce12._('CE12', 'executable renamed'),

  /// executable deprecated status changed
  ce13._('CE13', 'executable deprecated status changed'),

  /// executable changed from/to static/non-static
  ce14._('CE14', 'executable changed from/to static/non-static'),

  /// executable experimental status changed
  ce15._('CE15', 'executable experimental status changed'),

  /// executable parameter experimental status changed
  ce16._('CE16', 'executable parameter experimental status changed'),

  /// new entry point
  cp01._('CP01', 'new entry point'),

  /// entry point removed
  cp02._('CP02', 'entry point removed'),

  /// field removed
  cf01._('CF01', 'field removed'),

  /// field added
  cf02._('CF02', 'field added'),

  /// field deprecated status changed
  cf03._('CF03', 'field deprecated status changed'),

  /// field type changed
  cf04._('CF04', 'field type changed'),

  /// field static status changed
  cf05._('CF05', 'field static status changed'),

  /// field experimental status changed
  cf06._('CF06', 'field experimental status changed'),

  /// field readability changed
  cf07._('CF07', 'field readability changed'),

  /// field writability changed
  cf08._('CF08', 'field writability changed'),

  /// iOS platform added
  cpi01._('CPI01', 'iOS platform added'),

  /// iOS platform removed
  cpi02._('CPI02', 'iOS platform removed'),

  /// iOS platform constraint changed
  cpi03._('CPI03', 'iOS platform constraint changed'),

  /// Android platform added
  cpa01._('CPA01', 'Android platform added'),

  /// Android platform removed
  cpa02._('CPA02', 'Android platform removed'),

  /// Android platform min SDK added
  cpa03._('CPA03', 'Android platform min SDK added'),

  /// Android platform min SDK removed
  cpa04._('CPA04', 'Android platform min SDK removed'),

  /// Android platform min SDK changed
  cpa05._('CPA05', 'Android platform min SDK changed'),

  /// Android platform target SDK added
  cpa06._('CPA06', 'Android platform target SDK added'),

  /// Android platform target SDK removed
  cpa07._('CPA07', 'Android platform target SDK removed'),

  /// Android platform target SDK changed
  cpa08._('CPA08', 'Android platform target SDK changed'),

  /// Android platform compile SDK added
  cpa09._('CPA09', 'Android platform compile SDK added'),

  /// Android platform compile SDK removed
  cpa10._('CPA10', 'Android platform compile SDK removed'),

  /// Android platform compile SDK changed
  cpa11._('CPA11', 'Android platform compile SDK changed'),

  /// Type of SDK changed
  csdk01._('CSDK01', 'Type of SDK changed'),

  /// Min SDK version raised
  csdk02._('CSDK02', 'Min SDK version raised'),

  /// Dependency added
  cd01._('CD01', 'Dependency added'),

  /// Dependency removed
  cd02._('CD02', 'Dependency removed'),

  /// Dependency version changed
  cd03._('CD03', 'Dependency version changed'),
  ;

  const ApiChangeCode._(this.code, this.description);
  final String code;
  final String description;
}
