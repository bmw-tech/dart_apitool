# Reasons for detected changes

dart-apitool has a set of rules it applies in order to detect (breaking) changes. 
Those are often not clear at the first glance this is why this page tries to explain the different situations that lead to (breaking) changes and dart-apitool complaining about the selected version.

The general rule of thumb: If a change can break a user's code without the user changing something (but using semver) then we have a breaking change. 
Therefore, we only consider changes in the public API of a package (meaning: things reachable without including stuff from the src directory).

## Interfaces
Dart-apitool treats classes, interfaces (abstract classes), enums, mixins and extension classes as interfaces.

### CI01 An interface is removed
<a name="CI01" />
This is a breaking change because it is possible that a user of the library is using the interface. If the interface is removed, the user will get a compile error.

### CI02 An interface is added
<a name="CI02" />
Adding a new interface is an API change but a non-breaking one.

### CI03 An interface is renamed
<a name="CI03" />
dart-apitool is treating this as removal of the old interface and addition of the new interface. So a breaking change (remove) and a non-breaking change (add).

### CI04 supertype added
<a name="CI04" />
Adding a supertype extends the API of the interface and therefore is a non-breaking change.

### CI05 supertype removed
<a name="CI05" />
Removing a supertype potentially reduces the API of an interface and therefore is a breaking change.

### CI06 The type parameters of an interface are changed (generic)
<a name="CI06" />
This is a breaking change because it is possible that a user of the library is using the interface. If the type parameters are changed, the user will get a compile error. 
This is a very generic error message that gets used if the name of the type parameters are ignored (number of type parameters changed)

### CI07 Type parameter added
<a name="CI07" />
A type parameter has been added to the interface. This is a breaking change.

### CI08 Type parameter removed
<a name="CI08" />
A type parameter has been removed from the interface. This is a breaking change.

### CI09 The deprecated status of an interface is changed
<a name="CI09" />
This is a non-breaking change.

## Executables are constructors, methods and functions. They are all treated the same way.

### CE01 Executable parameter(s) are removed
<a name="CE01" />
Removing a parameter of an executable is always a breaking change as a library user might be using the parameter.

### CE02 Executable parameter(s) are added
<a name="CE02" />
Here it depends. If the parameter is an optional one then we have a non-breaking change. If it is a required parameter then this change is breaking.

### CE03 Executable parameter(s) are renamed
<a name="CE03" />
dart-apitool tries to detect renames (by using type / order of parameters). If it can detect a renaming then it depends on the fact if the parameter is named or not.
If a renaming of a named parameter is detected, then this change is breaking. A renaming of a positional parameter is not breaking.

### CE04 Executable parameters are reordered
<a name="CE04" />
That's a tricky one. Dart-apitool tries to match the old and the new parameters based on name and type to try to follow the reordering. If a reordering happened with named parameters and dart-apitool is able to match them then we have a non-breaking change. If it has (or dart-apitool things that it has) any effect on the user's code then we have a breaking change.

### CE05 Executable parameter requiredness is changed
<a name="CE05" />
If a parameter is made optional then this is a non-breaking change. If it is made required then this is a breaking change.

### CE06 Executable parameter deprecated status changed
<a name="CE06" />
this is a non-breaking change.

### CE07 Executable parameter named status changed
<a name="CE07" />
this is a breaking change.

### CE08 Executable parameter type is changed
<a name="CE08" />
this is a breaking change.

### CE09 Executable return type is changed
<a name="CE09" />
This is always a breaking change.

### CE10 Executable is removed
<a name="CE10" />
This is always a breaking change.

### CE11 Executable is added
<a name="CE11" />
This is probably a non-breaking change. For exceptions to this see "Required interfaces"

### CE12 Executable is renamed
<a name="CE12" />
This is treated as removal of the old executable and addition of the new one. So a breaking change (remove) and a (non-)breaking change (add).

### CE13 The deprecated status of an executable is changed
<a name="CE13" />
This is a non-breaking change.

### CE14 The declaration of an executable changed from/to non-static/static
<a name="CE14" />
This is a breaking change.

## Fields
### CF01 Field is removed
<a name="CF01" />
This is always a breaking change.

### CF02 Field added
<a name="CF02" />
Adding a field extends the API and therefore is non-breaking (Exception: required interfaces)

### CF03 Field deprecated status changed
<a name="CF03" />
this is a non-breaking change.

### CF04 Field type changed
<a name="CF04" />
This is a breaking change.

### CF05 Field declaration changed from/to non-static/static
<a name="CF05" />
This is a breaking change.

## Entry points
Entry points are the imports that lead to this type being usable. Any change in those entry points is an API change.

### CP01 New entry point
<a name="CP01" />
Means a type is accessible through an additional entry point. Non-breaking change

### CP02 entry point removed
<a name="CP02" />
Means a type is no longer accessible through an entry point. This is a breaking change as it can break users code

## Dependencies
### CD01 A dependency is added
<a name="CD01" />
This is a breaking change. This might not be obvious but adding a dependency can lead to a broken build of the user's code. For example, if the user is using a dependency that is not compatible with the new dependency then the user's code will not build.

### CD02 A dependency is removed
<a name="CD02" />
This is a non-breaking change. The user's code might rely on that dependency transitively but this is bad practice anyways ;)

### CD03 A dependency version is changed
<a name="CD03" />
This depends on the kind of version change. If the change is a patch or minor upgrade (so still in semver range) then the change is non-breaking. If the upgrade is a major upgrade then the change is breaking.

## Platform
Changes to the platform and its constraints are breaking if they are stricter than before. This means if the user's code is not compatible with the new constraints then the user's code will not build.

### CPI01 iOS platform added
<a name="CPI01" />
Platform got added. This is a breaking change.

### CPI02 iOS platform removed
<a name="CPI02" />
Platform got removed. This is a breaking change.

### CPI03 iOS platform constraint changed
<a name="CPI03" />
The version of the iOS platform constraint changed. This is a breaking change if the new constraint is stricter than the old one.

### CPA01 Android platform added
<a name="CPA01" />
Platform got added. This is a breaking change.

### CPA02 Android platform removed
<a name="CPA02" />
Platform got removed. This is a breaking change.

### CPA03 Android platform min SDK version added
<a name="CPA03" />
Min SDK Version for Android got added. This is a breaking change.

### CPA04 Android platform min SDK version removed
<a name="CPA04" />
Min SDK Version for Android got removed. This is a non-breaking change.

### CPA05 Android platform min SDK version changed
<a name="CPA05" />
Min SDK Version for Android got changed. This is a breaking change if the new constraint is stricter than the old one.

### CPA06 Android platform target SDK version added
<a name="CPA06" />
Target SDK Version for Android got added. This is a breaking change.

### CPA07 Android platform target SDK version removed
<a name="CPA07" />
Target SDK Version for Android got removed. This is a non-breaking change.

### CPA08 Android platform target SDK version changed
<a name="CPA08" />
Target SDK Version for Android got changed. This is a breaking change if the new constraint is stricter than the old one.

### CPA09 Android platform compile SDK version added
<a name="CPA09" />
Compile SDK Version for Android got added. This is a breaking change.

### CPA10 Android platform compile SDK version removed
<a name="CPA10" />
Compile SDK Version for Android got removed. This is a non-breaking change.

### CPA11 Android platform compile SDK version changed
<a name="CPA11" />
Compile SDK Version for Android got changed. This is a breaking change if the new constraint is stricter than the old one.


## SDK constraints
### CSDK01 SDK Type changed
<a name="CSDK01" />
This is a breaking change. (e.g. Dart → Flutter)

### CSDK02 Min SDK version got raised
<a name="CSDK02" />
This is a breaking change.

## Required interfaces
Required interfaces are interfaces that are meant to be implemented by the user of the library. Dart-apitool detects those interfaces if they are abstract classes and passed as a parameter to an executable or are used as the type of a setter. 
This means if an interface is required then adding executables or fields to it is a breaking change as it may affect the user's code.
