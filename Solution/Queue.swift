public class Queue<T> {
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
  private var count: Int = 0

  public init() { }

  /// Returns the number of elements in the queue - O(1)
  public var length: Int {
    return count
  }

  /// Checks if the queue is empty - O(1)
  public var isEmpty: Bool {
    return count == 0
  }

  /// Enqueues (adds) an element to the queue - O(1)
  public func enqueue(_ value: T) {
    let newNode = ListNode(value)
    if let tailNode = tail {
      tailNode.next = newNode
      newNode.prev = tailNode
    } else {
      head = newNode
    }
    tail = newNode
    count += 1  // Increment count
  }

  /// Dequeues (removes) an element from the front - O(1)
  @discardableResult
  public func dequeue() -> T? {
    guard let headNode = head else { return nil }
    let value = headNode.val
    head = headNode.next
    head?.prev = nil

    if head == nil {
      tail = nil
    }
    count -= 1  // Decrement count
    return value
  }

  /// Returns the front element without removing it - O(1)
  public func peek() -> T? {
    return head?.val
  }
}
