import Foundation
import Solution

extension Solution {
  /// 20. Valid Parentheses
  func isValid(_ s: String) -> Bool {
    var openedStack: [String] = []

    for char in s {
      switch char {
      case "(", "{", "[":
        openedStack.append(String(char))
      case ")":
        if openedStack.popLast() != "("  {
          return false
        }
      case "}":
        if openedStack.popLast() != "{"  {
          return false
        }
      case "]":
        if openedStack.popLast() != "["  {
          return false
        }
      default:
        fatalError("Unexpected character: \(char)")
      }
    }

    // if stack still has some chars, we did not closed all chars.
    return openedStack.isEmpty
  }

  /// 1047. Remove All Adjacent Duplicates In String
  func removeDuplicates(_ s: String) -> String {
    var stack: [Character] = []
    for char in s {
      if char == stack.last {
        stack.removeLast()
      } else {
        stack.append(char)
      }
    }
    return String(stack)
  }

  /// 844. Backspace String Compare
  func backspaceCompare(_ s: String, _ t: String) -> Bool {
    func processBackspaces(_ str: String) -> [Character] {
      var stack: [Character] = []
      for char in str {
        if char == "#" {
          _ = stack.popLast()
        } else {
          stack.append(char)
        }
      }
      return stack
    }

    return processBackspaces(s) == processBackspaces(t)
  }

  /// 71. Simplify Path
  func simplifyPath(_ path: String) -> String {
    let components = path.split(separator: "/")
    var canonicalPath: [String] = []

    for pathComponent in components {
      switch pathComponent {
      case "..":
        _ = canonicalPath.popLast()
      case ".", "":
        continue
      default:
        canonicalPath.append(String(pathComponent))
      }
    }

    return "/" + canonicalPath.joined(separator: "/")
  }

  /// 1544. Make The String Great
  func makeGood(_ s: String) -> String {
    var goodChars: [Character] = []
    for char in s {
      let toggledCase = Character(
        char.isUppercase
        ? char.lowercased()
        : char.uppercased()
      )

      if goodChars.last == toggledCase {
        goodChars.removeLast()
      } else {
        goodChars.append(char)
      }
    }
    return String(goodChars)
  }

  /// 933. Number of Recent Calls
  class RecentCounter {
    private var recentRequests: Queue<Int>

    init() {
      self.recentRequests = .init()
    }

    func ping(_ t: Int) -> Int {
      // remove outdated calls
      let range = (t-3000)...t
      while let first = recentRequests.peek(), !range.contains(first) {
        recentRequests.dequeue()
      }

      recentRequests.enqueue(t)

      return recentRequests.length
    }
  }

  /// 346. Moving Average from Data Stream
  class MovingAverage {
    private let size: Int
    private var stream: [Int]

    init(_ size: Int) {
      self.size = size
      self.stream = []
    }

    func next(_ val: Int) -> Double {
      stream.append(val)
      let slice = stream.suffix(size)
      let sum = slice.reduce(0, +)
      return Double(sum) / Double(slice.count)
    }
  }
}
