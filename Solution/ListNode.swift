public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init(_ val: Int) {
    self.val = val
    self.next = nil
  }

  public convenience init?(description: String) {
    let nodes = description.split(separator: " -> ").compactMap({ Int($0) })
    self.init(nodes: nodes)
  }

  public init?(nodes: Array<Int>) {
    guard !nodes.isEmpty else { return nil }
    let head = ListNode(nodes[0])
    var current: ListNode? = head
    for nodeValue in nodes[1...] {
      let newNode = ListNode(nodeValue)
      current?.next = newNode
      current = newNode
    }
    self.val = head.val
    self.next = head.next
  }
}

public extension ListNode {
  @discardableResult
  func removeNext() -> ListNode? {
    guard let removedNode = self.next else { return nil }
    self.next = removedNode.next
    removedNode.next = nil
    return removedNode
  }
}

extension ListNode: CustomStringConvertible {
  public var description: String {
    var visited = Set<ObjectIdentifier>()
    var current: ListNode? = self
    var result = ""

    while let node = current {
      let id = ObjectIdentifier(node)

      if visited.contains(id) {
        result += "(\(node.val)) ↺"
        break
      }

      visited.insert(id)
      result += "\(node.val)"
      if node.next != nil {
        result += " -> "
      }
      current = node.next
    }

    return result
  }
}

//struct ObjectSet<E: AnyObject> {
//  var elements: Set<ObjectIdentifier> = []
//
//  mutating func insert(_ element: E) {
//    elements.insert(ObjectIdentifier(element))
//  }
//  
//  func contains(_ element: E) -> Bool {
//    return elements.contains(ObjectIdentifier(element))
//  }
//}

//extension ListNode: Equatable, Hashable {
//  public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
//    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
//  }
//
//  public func hash(into hasher: inout Hasher) {
//    hasher.combine(ObjectIdentifier(self))
//  }
//}

