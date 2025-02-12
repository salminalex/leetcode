import Foundation
import Solution

extension Solution {
  /// 141. Linked List Cycle
  func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head

    while fast != nil && fast?.next != nil {
      if fast === slow {
        return true
      }
      slow = slow?.next // 1 step
      fast = fast?.next?.next // 2 steps
    }

    return false
  }

  /// 876. Middle of the Linked List
  func middleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head

    while fast?.next != nil {
      slow = slow?.next
      fast = fast?.next?.next
    }

    return slow
  }

  /// 83. Remove Duplicates from Sorted List
  func deleteDuplicates(_ head: ListNode?) -> ListNode? {
    var dummyHead = head

    while dummyHead?.next != nil {
      while dummyHead?.val == dummyHead?.next?.val {
        dummyHead?.next = dummyHead?.next?.next
      }
      dummyHead = dummyHead?.next
    }

    return head
  }

  func deleteDuplicates1(_ head: ListNode?) -> ListNode? {
    var i = head
    var j = head?.next

    while j != nil {
      if i?.val == j?.val {
        i?.next = j?.next
        j = j?.next
      } else {
        i = i?.next
        j = j?.next
      }
    }

    return head
  }

  func reverseList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var curr = head

    while curr != nil {
      let next = curr?.next
      curr?.next = prev
      prev = curr
      curr = next
    }

    return prev
  }

  func swapPairsRecursively(_ head: ListNode?) -> ListNode? {
    // 1. Check non empty list
    guard let lhsNode = head else {
      return head
    }

    // 2. Check list has more than 1 element
    guard let rhsNode = head?.next else {
      return head
    }

    // 3. Replace rhs ref to the remaining recursive result
    lhsNode.next = swapPairsRecursively(rhsNode.next)
    // 4. Put rhs to before lhs
    rhsNode.next = lhsNode

    return rhsNode
  }

  func swapPairs(_ head: ListNode?) -> ListNode? {
    let dummy = ListNode(0)
    dummy.next = head

    var prevRhs = dummy
    var currLhs = dummy.next

    while currLhs != nil && currLhs!.next != nil {
      let currRhs = currLhs!.next
      let nextLhs = currLhs!.next!.next

      prevRhs.next = currRhs
      currRhs!.next = currLhs
      currLhs!.next = nextLhs

      prevRhs = currLhs!
      currLhs = nextLhs
    }

    return dummy.next
  }
}
