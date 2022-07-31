export 'src/api_relevant_elements_collector.dart';
export 'src/referenced_files_collector.dart';

class ClassWithTypeArgument<T> {
  final T member;

  ClassWithTypeArgument(this.member);

  R castTo<R>() {
    return member as R;
  }
}

ClassWithTypeArgument<String> publicTopLevelVar = ClassWithTypeArgument('test');

R publicTopLevelMethod<T, R>(ClassWithTypeArgument<T> arg) {
  return arg.castTo<R>();
}
