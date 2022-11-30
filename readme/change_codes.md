# Reasons for detected changes

dart-apitool has a set of rules it applies in order to detect (breaking) changes. 
Those are often not clear at the first glance this is why this page tries to explain the different situations that lead to (breaking) changes and dart-apitool complaining about the selected version.

The general rule of thumb: If a change can break a user's code without the user changing something (but using semver) then we have a breaking change. 
Therefore, we only consider changes in the public API of a package (meaning: things reachable without including stuff from the src directory).

## Interfaces
Dart-apitool treats classes, interfaces (abstract classes), enums, mixins and extension classes as interfaces.

### <a name="CI01" />An interface is removed (CI01)
This is a breaking change because it is possible that a user of the library is using the interface. If the interface is removed, the user will get a compile error.

### <a name="CI02" />An interface is added (CI02)
Adding a new interface is an API change but a non-breaking one.

### <a name="CI03" />An interface is renamed (CI03)
dart-apitool is treating this as removal of the old interface and addition of the new interface. So a breaking change (remove) and a non-breaking change (add).

### <a name="CI04" />supertype added (CI04)
Adding a supertype extends the API of the interface and therefore is a non-breaking change.

### <a name="CI05" />supertype removed (CI05)
Removing a supertype potentially reduces the API of an interface and therefore is a breaking change.

### <a name="CI06" />The type parameters of an interface are changed (generic) (CI06)
This is a breaking change because it is possible that a user of the library is using the interface. If the type parameters are changed, the user will get a compile error. 
This is a very generic error message that gets used if the name of the type parameters are ignored (number of type parameters changed)

### <a name="CI07" />Type parameter added (CI07)
A type parameter has been added to the interface. This is a breaking change.

### <a name="CI08" />Type parameter removed (CI08)
A type parameter has been removed from the interface. This is a breaking change.

### <a name="CI09" />The deprecated status of an interface is changed (CI09)
This is a non-breaking change.

### <a name="CI10" />The experimental status of an interface is changed (CI10)
If the flag got removed then this change is non-breaking. Adding an experimental flag is considered a breaking change.

## Executables are constructors, methods and functions. They are all treated the same way.

### <a name="CE01" />Executable parameter(s) are removed (CE01)
Removing a parameter of an executable is always a breaking change as a library user might be using the parameter.

### <a name="CE02" />Executable parameter(s) are added (CE02)
Here it depends. If the parameter is an optional one then we have a non-breaking change. If it is a required parameter then this change is breaking.

### <a name="CE03" />Executable parameter(s) are renamed (CE03)
dart-apitool tries to detect renames (by using type / order of parameters). If it can detect a renaming then it depends on the fact if the parameter is named or not.
If a renaming of a named parameter is detected, then this change is breaking. A renaming of a positional parameter is not breaking.

### <a name="CE04" />Executable parameters are reordered (CE04)
That's a tricky one. Dart-apitool tries to match the old and the new parameters based on name and type to try to follow the reordering. If a reordering happened with named parameters and dart-apitool is able to match them then we have a non-breaking change. If it has (or dart-apitool things that it has) any effect on the user's code then we have a breaking change.

### <a name="CE05" />Executable parameter requiredness is changed (CE05)
If a parameter is made optional then this is a non-breaking change. If it is made required then this is a breaking change.

### <a name="CE06" />Executable parameter deprecated status changed (CE06)
this is a non-breaking change.

### <a name="CE07" />Executable parameter named status changed (CE07)
this is a breaking change.

### <a name="CE08" />Executable parameter type is changed (CE08)
this is a breaking change.

### <a name="CE09" />Executable return type is changed (CE09)
This is always a breaking change.

### <a name="CE10" />Executable is removed (CE10)
This is always a breaking change.

### <a name="CE11" />Executable is added (CE11)
This is probably a non-breaking change. For exceptions to this see "Required interfaces"

### <a name="CE12" />Executable is renamed (CE12)
This is treated as removal of the old executable and addition of the new one. So a breaking change (remove) and a (non-)breaking change (add).

### <a name="CE13" />The deprecated status of an executable is changed (CE13)
This is a non-breaking change.

### <a name="CE14" />The declaration of an executable changed from/to non-static/static (CE14)
This is a breaking change.

### <a name="CE15" />The experimental status of an executable is changed (CE15)
If the flag got removed then this change is non-breaking. Adding an experimental flag is considered a breaking change.

### <a name="CE16" />Executable parameter experimental status is changed (CE16)
If the flag got removed then this change is non-breaking. Adding an experimental flag is considered a breaking change.

## Fields
### <a name="CF01" />Field is removed (CF01)
This is always a breaking change.

### <a name="CF02" />Field added (CF02)
Adding a field extends the API and therefore is non-breaking (Exception: required interfaces)

### <a name="CF03" />Field deprecated status changed (CF03)
this is a non-breaking change.

### <a name="CF04" />Field type changed (CF04)
This is a breaking change.

### <a name="CF05" />Field declaration changed from/to non-static/static (CF05)
This is a breaking change.

### <a name="CF06" />Field experimental status changed (CF06)
If the flag got removed then this change is non-breaking. Adding an experimental flag is considered a breaking change.

## Entry points
Entry points are the imports that lead to this type being usable. Any change in those entry points is an API change.

### <a name="CP01" />New entry point (CP01)
Means a type is accessible through an additional entry point. Non-breaking change

### <a name="CP02" />entry point removed (CP02)
Means a type is no longer accessible through an entry point. This is a breaking change as it can break users code

## Dependencies
### <a name="CD01" />A dependency is added (CD01)
This is a breaking change. This might not be obvious but adding a dependency can lead to a broken build of the user's code. For example, if the user is using a dependency that is not compatible with the new dependency then the user's code will not build.

### <a name="CD02" />A dependency is removed (CD02)
This is a non-breaking change. The user's code might rely on that dependency transitively but this is bad practice anyways ;)

### <a name="CD03" />A dependency version is changed (CD03)
This depends on the kind of version change. If the change is a patch or minor upgrade (so still in semver range) then the change is non-breaking. If the upgrade is a major upgrade then the change is breaking.

## Platform
Changes to the platform and its constraints are breaking if they are stricter than before. This means if the user's code is not compatible with the new constraints then the user's code will not build.

### <a name="CPI01" />iOS platform added (CPI01)
Platform got added. This is a breaking change.

### <a name="CPI02" />iOS platform removed (CPI02)
Platform got removed. This is a breaking change.

### <a name="CPI03" />iOS platform constraint changed (CPI03)
The version of the iOS platform constraint changed. This is a breaking change if the new constraint is stricter than the old one.

### <a name="CPA01" />Android platform added (CPA01)
Platform got added. This is a breaking change.

### <a name="CPA02" />Android platform removed (CPA02)
Platform got removed. This is a breaking change.

### <a name="CPA03" />Android platform min SDK version added (CPA03)
Min SDK Version for Android got added. This is a breaking change.

### <a name="CPA04" />Android platform min SDK version removed (CPA04)
Min SDK Version for Android got removed. This is a non-breaking change.

### <a name="CPA05" />Android platform min SDK version changed (CPA05)
Min SDK Version for Android got changed. This is a breaking change if the new constraint is stricter than the old one.

### <a name="CPA06" />Android platform target SDK version added (CPA06)
Target SDK Version for Android got added. This is a breaking change.

### <a name="CPA07" />Android platform target SDK version removed (CPA07)
Target SDK Version for Android got removed. This is a non-breaking change.

### <a name="CPA08" />Android platform target SDK version changed (CPA08)
Target SDK Version for Android got changed. This is a breaking change if the new constraint is stricter than the old one.

### <a name="CPA09" />Android platform compile SDK version added (CPA09)
Compile SDK Version for Android got added. This is a breaking change.

### <a name="CPA10" />Android platform compile SDK version removed (CPA10)
Compile SDK Version for Android got removed. This is a non-breaking change.

### <a name="CPA11" />Android platform compile SDK version changed (CPA11)
Compile SDK Version for Android got changed. This is a breaking change if the new constraint is stricter than the old one.


## SDK constraints
### <a name="CSDK01" />SDK Type changed (CSDK01)
This is a breaking change. (e.g. Dart → Flutter)

### <a name="CSDK02" />Min SDK version got raised (CSDK02)
This is a breaking change.

## Required interfaces
Required interfaces are interfaces that are meant to be implemented by the user of the library. Dart-apitool detects those interfaces if they are abstract classes and passed as a parameter to an executable or are used as the type of a setter. 
This means if an interface is required then adding executables or fields to it is a breaking change as it may affect the user's code.
