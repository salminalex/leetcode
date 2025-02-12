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
}
