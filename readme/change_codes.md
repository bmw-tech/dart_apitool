# Reasons for detected changes

dart-apitool has a set of rules it applies in order to detect (breaking) changes. 
Those are often not clear at the first glance this is why this page tries to explain the different situations that lead to (breaking) changes and dart-apitool complaining about the selected version.

The general rule of thumb: If a change can break a user's code without the user changing something (but using semver) then we have a breaking change. 
Therefore, we only consider changes in the public API of a package (meaning: things reachable without including stuff from the src directory).

## Interfaces
Dart-apitool treats classes, interfaces (abstract classes), enums, mixins and extension classes as interfaces.

<a name="CI01" />
### CI01 An interface is removed
This is a breaking change because it is possible that a user of the library is using the interface. If the interface is removed, the user will get a compile error.

<a name="CI02" />
### CI02 An interface is added
Adding a new interface is an API change but a non-breaking one.

<a name="CI03" />
### CI03 An interface is renamed
dart-apitool is treating this as removal of the old interface and addition of the new interface. So a breaking change (remove) and a non-breaking change (add).

<a name="CI04" />
### CI04 supertype added
Adding a supertype extends the API of the interface and therefore is a non-breaking change.

<a name="CI05" />
### CI05 supertype removed
Removing a supertype potentially reduces the API of an interface and therefore is a breaking change.

<a name="CI06" />
### CI06 The type parameters of an interface are changed (generic)
This is a breaking change because it is possible that a user of the library is using the interface. If the type parameters are changed, the user will get a compile error. 
This is a very generic error message that gets used if the name of the type parameters are ignored (number of type parameters changed)

<a name="CI07" />
### CI07 Type parameter added
A type parameter has been added to the interface. This is a breaking change.

<a name="CI08" />
### CI08 Type parameter removed
A type parameter has been removed from the interface. This is a breaking change.

<a name="CI09" />
### CI09 The deprecated status of an interface is changed
This is a non-breaking change.

## Executables are constructors, methods and functions. They are all treated the same way.

<a name="CE01" />
### CE01 Executable parameter(s) are removed
Removing a parameter of an executable is always a breaking change as a library user might be using the parameter.

<a name="CE02" />
### CE02 Executable parameter(s) are added
Here it depends. If the parameter is an optional one then we have a non-breaking change. If it is a required parameter then this change is breaking.

<a name="CE03" />
### CE03 Executable parameter(s) are renamed
dart-apitool tries to detect renames (by using type / order of parameters). If it can detect a renaming then it depends on the fact if the parameter is named or not.
If a renaming of a named parameter is detected, then this change is breaking. A renaming of a positional parameter is not breaking.

<a name="CE04" />
### CE04 Executable parameters are reordered
That's a tricky one. Dart-apitool tries to match the old and the new parameters based on name and type to try to follow the reordering. If a reordering happened with named parameters and dart-apitool is able to match them then we have a non-breaking change. If it has (or dart-apitool things that it has) any effect on the user's code then we have a breaking change.

<a name="CE05" />
### CE05 Executable parameter requiredness is changed
If a parameter is made optional then this is a non-breaking change. If it is made required then this is a breaking change.

<a name="CE06" />
### CE06 Executable parameter deprecated status changed
this is a non-breaking change.

<a name="CE07" />
### CE07 Executable parameter named status changed
this is a breaking change.

<a name="CE08" />
### CE08 Executable parameter type is changed
this is a breaking change.

<a name="CE09" />
### CE09 Executable return type is changed
This is always a breaking change.

<a name="CE10" />
### CE10 Executable is removed
This is always a breaking change.

<a name="CE11" />
### CE11 Executable is added
This is probably a non-breaking change. For exceptions to this see "Required interfaces"

<a name="CE12" />
### CE12 Executable is renamed
This is treated as removal of the old executable and addition of the new one. So a breaking change (remove) and a (non-)breaking change (add).

<a name="CE13" />
### CE13 The deprecated status of an executable is changed
This is a non-breaking change.

<a name="CE14" />
### CE14 The declaration of an executable changed from/to non-static/static
This is a breaking change.

## Fields
<a name="CF01" />
### CF01 Field is removed
This is always a breaking change.

<a name="CF02" />
### CF02 Field added
Adding a field extends the API and therefore is non-breaking (Exception: required interfaces)

<a name="CF03" />
### CF03 Field deprecated status changed
this is a non-breaking change.

<a name="CF04" />
### CF04 Field type changed
This is a breaking change.

<a name="CF05" />
### CF05 Field declaration changed from/to non-static/static
This is a breaking change.

## Entry points
Entry points are the imports that lead to this type being usable. Any change in those entry points is an API change.

<a name="CP01" />
### CP01 New entry point
Means a type is accessible through an additional entry point. Non-breaking change

<a name="CP02" />
### CP02 entry point removed
Means a type is no longer accessible through an entry point. This is a breaking change as it can break users code

## Dependencies
<a name="CD01" />
### CD01 A dependency is added
This is a breaking change. This might not be obvious but adding a dependency can lead to a broken build of the user's code. For example, if the user is using a dependency that is not compatible with the new dependency then the user's code will not build.

<a name="CD02" />
### CD02 A dependency is removed
This is a non-breaking change. The user's code might rely on that dependency transitively but this is bad practice anyways ;)

<a name="CD03" />
### CD03 A dependency version is changed
This depends on the kind of version change. If the change is a patch or minor upgrade (so still in semver range) then the change is non-breaking. If the upgrade is a major upgrade then the change is breaking.

## Platform
Changes to the platform and its constraints are breaking if they are stricter than before. This means if the user's code is not compatible with the new constraints then the user's code will not build.

<a name="CPI01" />
### CPI01 iOS platform added
Platform got added. This is a breaking change.

<a name="CPI02" />
### CPI02 iOS platform removed
Platform got removed. This is a breaking change.

<a name="CPI03" />
### CPI03 iOS platform constraint changed
The version of the iOS platform constraint changed. This is a breaking change if the new constraint is stricter than the old one.

<a name="CPA01" />
### CPA01 Android platform added
Platform got added. This is a breaking change.

<a name="CPA02" />
### CPA02 Android platform removed
Platform got removed. This is a breaking change.

<a name="CPA03" />
### CPA03 Android platform min SDK version added
Min SDK Version for Android got added. This is a breaking change.

<a name="CPA04" />
### CPA04 Android platform min SDK version removed
Min SDK Version for Android got removed. This is a non-breaking change.

<a name="CPA05" />
### CPA05 Android platform min SDK version changed
Min SDK Version for Android got changed. This is a breaking change if the new constraint is stricter than the old one.

<a name="CPA06" />
### CPA06 Android platform target SDK version added
Target SDK Version for Android got added. This is a breaking change.

<a name="CPA07" />
### CPA07 Android platform target SDK version removed
Target SDK Version for Android got removed. This is a non-breaking change.

<a name="CPA08" />
### CPA08 Android platform target SDK version changed
Target SDK Version for Android got changed. This is a breaking change if the new constraint is stricter than the old one.

<a name="CPA09" />
### CPA09 Android platform compile SDK version added
Compile SDK Version for Android got added. This is a breaking change.

<a name="CPA10" />
### CPA10 Android platform compile SDK version removed
Compile SDK Version for Android got removed. This is a non-breaking change.

<a name="CPA11" />
### CPA11 Android platform compile SDK version changed
Compile SDK Version for Android got changed. This is a breaking change if the new constraint is stricter than the old one.


## SDK constraints
<a name="CSDK01" />
### CSDK01 SDK Type changed
This is a breaking change. (e.g. Dart → Flutter)

<a name="CSDK02" />
### CSDK02 Min SDK version got raised
This is a breaking change.

## Required interfaces
Required interfaces are interfaces that are meant to be implemented by the user of the library. Dart-apitool detects those interfaces if they are abstract classes and passed as a parameter to an executable or are used as the type of a setter. 
This means if an interface is required then adding executables or fields to it is a breaking change as it may affect the user's code.
