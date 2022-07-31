export 'src/ApiRelevantElementsCollector.dart';
export 'src/ReferencedFilesCollector.dart';

class ClassWithTypeArgument<T> {
  final T member;

  ClassWithTypeArgument(this.member);

  R castTo<R>() {
    return member as R;
  }
}
