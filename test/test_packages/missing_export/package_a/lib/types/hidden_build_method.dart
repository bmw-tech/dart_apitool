/// PublicClass contains a [PrivateClass] field and a private constructor accepting it
class PublicClass {
  PrivateClass _privateClass;
  const PublicClass._(this._privateClass);
}

/// this class is "private" (is not exported)
class PrivateClass {}

// build method uses a "PrivateClass" as an argument to build the PublicClass instance
PublicClass buildPublicClass(PrivateClass privateClass) =>
    PublicClass._(privateClass);
