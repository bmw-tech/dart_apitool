/// specifies how a type is used
enum TypeUsage {
  /// the type is provided in the public API
  provide,

  /// the type is used to be passed into the API
  input,

  /// the type is used to be returned from the API
  output,

  /// the type is used as a hierarchy element (base class, mixin, interface, type parameter ...)
  hierarchy,
}
