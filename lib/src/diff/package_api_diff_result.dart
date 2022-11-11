import '../model/model.dart';
import 'api_change.dart';

/// represents a tree node in the hierarchical change representation
class ApiChangeTreeNode {
  /// the declaration represented by this node
  final Declaration? nodeDeclaration;

  /// the changes [nodeDeclaration] has
  final List<ApiChange> changes;

  /// the children of this node
  final Map<Declaration, ApiChangeTreeNode> children;

  /// creates a new ApiChangeTreeNode instance
  ApiChangeTreeNode({
    required this.nodeDeclaration,
    List<ApiChange>? changes,
  })  : changes = changes ?? [],
        children = {};
}

/// represents the result of a diff run
class PackageApiDiffResult {
  /// API changes that the diff run detected
  final List<ApiChange> apiChanges;

  /// whether this diff result contains any changes
  bool get hasChanges {
    return apiChanges.isNotEmpty;
  }

  /// root node of the hierarchical representation of the changes
  final rootNode = ApiChangeTreeNode(nodeDeclaration: null);

  /// adds an API change. This is used by the [PackageApiDiffer] to add API changes.
  /// This method makes sure that the change is added to the list of changes as well as getting inserted into the hierarchical representation
  void addApiChange(ApiChange change) {
    var currentNode = rootNode;
    for (int i = change.contextTrace.length - 1; i >= 0; i--) {
      final currentContext = change.contextTrace[i];
      if (!currentNode.children.containsKey(currentContext)) {
        currentNode.children[currentContext] =
            ApiChangeTreeNode(nodeDeclaration: currentContext);
      }
      currentNode = currentNode.children[currentContext]!;
    }
    currentNode.changes.add(change);
    apiChanges.add(change);
  }

  /// calls [addApiChange] for all [ApiChange]s in [changes]
  void addApiChanges(Iterable<ApiChange> changes) {
    for (final change in changes) {
      addApiChange(change);
    }
  }

  PackageApiDiffResult() : apiChanges = [];
}
