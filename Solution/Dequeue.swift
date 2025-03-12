public class Dequeue<T> {
  private class ListNode {
    var val: T
    var next: ListNode?
    var prev: ListNode?

    init(_ val: T, next: ListNode? = nil, prev: ListNode? = nil) {
      self.val = val
      self.next = next
      self.prev = prev
    }
  }

  private var head: ListNode?
  private var tail: ListNode?

  public init() { }

  public var first: T? {
    head?.val
  }

  public func addFirst(_ value: T) {
    let newNode = ListNode(value)
    if let headNode = head {
      headNode.prev = newNode
      newNode.next = headNode
    } else {
      tail = newNode
    }
    head = newNode
  }

  @discardableResult
  public func removeFirst() -> T? {
    guard let headNode = head else { return nil }
    let value = headNode.val
    head = headNode.next
    head?.prev = nil

    if head == nil {
      tail = nil
    }
    return value
  }

  public var last: T? {
    tail?.val
  }

  public func addLast(_ value: T) {
    let newNode = ListNode(value)
    if let tailNode = tail {
      tailNode.next = newNode
      newNode.prev = tailNode
    } else {
      head = newNode
    }
    tail = newNode
  }

  @discardableResult
  public func removeLast() -> T? {
    guard let tailNode = tail else { return nil }
    let value = tailNode.val
    tail = tailNode.prev
    tail?.next = nil

    if tail == nil {
      head = nil
    }
    return value
  }
}
