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

  /// 739. Daily Temperatures
  func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
    var ans = Array(repeating: 0, count: temperatures.count)
    var stack = [Int]()

    for i in temperatures.indices {
      while !stack.isEmpty, temperatures[stack.last!] < temperatures[i] {
        let j = stack.removeLast()
        ans[j] = i - j
      }
      stack.append(i)
    }
    return ans
  }

  /// 239. Sliding Window Maximum
  func maxSlidingWindowBF(_ nums: [Int], _ k: Int) -> [Int] {
    var ans = [Int]()

    for i in 0...(nums.count - k) {
      var windMax = Int.min
      for j in i..<i+k {
        windMax = max(windMax, nums[j])
      }
      ans.append(windMax)
    }

    return ans
  }

  func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    let deueue: Dequeue<Int> = .init()
    var ans = [Int]()

    for currIndex in nums.indices {
      // maintain monotonically decreasing stack
      while let minIndex = deueue.last, nums[minIndex] < nums[currIndex] {
        deueue.removeLast()
      }
      deueue.addLast(currIndex)

      // remove index of first max element if it's outside of the window
      if (currIndex - k) == deueue.first {
        deueue.removeFirst()
      }

      // add max to answer when reached window size
      if let maxIndex = deueue.first, currIndex >= k - 1 {
        ans.append(nums[maxIndex])
      }
    }

    return ans
  }

  func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var ans = [Int]()
    var map = [Int: Int]()

    for num in nums1 {
      guard let index = nums2.firstIndex(of: num) else {
        ans.append(-1)
        continue
      }

      if let res = nums2[index..<nums2.endIndex].first(where: { $0 > num }) {
        ans.append(res)
      } else {
        ans.append(-1)
      }
    }

    return ans
  }
}
