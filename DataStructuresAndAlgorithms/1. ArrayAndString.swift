import Foundation
import Solution

extension Solution {
  func sortedSquares(_ nums: [Int]) -> [Int] {
    var res: [Int] = []
    var i = 0
    var j = nums.count-1

    while i <= j {
      let left =  nums[i] * nums[i]
      let right = nums[j] * nums[j]
      if left >= right {
        res.append(left)
        i += 1
      } else {
        res.append(right)
        j -= 1
      }
    }

    return res.reversed()
  }

  func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
    let numsDouble = nums.map(Double.init)
    let kDouble = Double(k)
    var ans = -Double.infinity

    for i in 0...(nums.count - k) {
      let sum = numsDouble[i..<i+k].reduce(0, +)
      let avg = sum / kDouble
      ans = max(ans, avg)
    }

    return ans
  }

  func longestOnes(_ nums: [Int], _ k: Int) -> Int {
    var left = 0
    var curr = 0
    var ans = 0

    for right in 0..<nums.count {
      if nums[right] == 0 {
        curr += 1
      }

      while curr > k {
        if nums[left] == 0 {
          curr -= 1
        }
        left += 1
      }

      ans = max(ans, right - left + 1)
    }

    return ans
  }

  func runningSum(_ nums: [Int]) -> [Int] {
    nums.reduce([Int]()) { partialResult, num in
      let next = (partialResult.last ?? 0) + num
      return partialResult + [next]
    }
  }

  func minStartValue(_ nums: [Int]) -> Int {
    let prefixSum = nums.reduce([Int]()) { partialResult, num in
      let next = (partialResult.last ?? 0) + num
      return partialResult + [next]
    }

    var res = 1

    for sum in prefixSum {
      while sum + res < 1 {
        res += 1
      }
    }

    return res
  }

  func getAverages(_ nums: [Int], _ k: Int) -> [Int] {
    let total = 2 * k + 1
    var res: [Int] = []
    var sumCache: [Int] = []

    for i in 0..<nums.count {
      let next = (sumCache.last ?? 0) + nums[i]
      sumCache.append(next)
    }

    for i in 0..<nums.count {
      let from = i - k
      let to = i + k
      if from >= 0, to < nums.count {
        let sum = sumCache[to] - sumCache[from] + nums[from]
        res.append(sum / total)
      } else {
        res.append(-1)
      }
    }

    return res
  }

  func reverseWords(_ s: String) -> String {
    return s.split(separator: " ").map { String($0.reversed()) }.joined(separator: " ")
  }

  /// 3. Longest Substring Without Repeating Characters
  /// Given a string s, find the length of the longest substring
  /// without repeating characters.
  func lengthOfLongestSubstringSlidingWindow(_ s: String) -> Int {
    guard !s.isEmpty else {
      return 0
    }

    var left = s.startIndex
    var ans = 0

    for right in s.indices {
      while Set(s[left...right]).count != s[left...right].count {
        left = s.index(after: left)
      }

      ans = max(ans, s[left...right].count)
    }

    return ans
  }

  // 283. Move Zeroes
  func moveZeroes(_ nums: inout [Int]) {
    var lastNonZeroIndex = 0
    for i in 0..<nums.count {
      if nums[i] != 0 {
        nums.swapAt(i, lastNonZeroIndex)
        lastNonZeroIndex += 1
      }
    }
  }

  // 242. Valid Anagram
  func isAnagram(_ s: String, _ t: String) -> Bool {
    func formTable(_ str: String) -> [Character: Int] {
      var dict = [Character: Int](minimumCapacity: 26)
      for char in str {
        dict[char, default: 0] += 1
      }
      return dict
    }

    return formTable(s) == formTable(t)
  }

  // 56. Merge Intervals
  // Sorted intervals will have left boundary consistently increasing,
  // iterating over sorted intervals will allow compare right boundary
  // of previous interval with the left boundary of the next interval
  // to verify intersection. max right of previous and next interval
  // will be the right of the merged interval in case of intersection.
  func merge(_ intervals: [[Int]]) -> [[Int]] {
    var res = [[Int]]()

    for right in intervals.sorted(by: { $0[0] < $1[0] }) {
      // if it's just first interval, just append it to res
      guard let left = res.last else {
        res.append(right)
        continue
      }

      // if there is an intersection, merge left and right
      if left[1] >= right[0] {
        res.removeLast()
        res.append([left[0], max(left[1], right[1])])
      }

      // otherwise just add new interval
      else {
        res.append(right)
      }
    }

    return res
  }

  // 75. Sort Colors
  // Form counts of every color and then reduce counts array into
  // a resulting sorted colors array. At counts array index represents
  // the color(0, 1, 2) and the value at this index represents count of
  // this colors. We use counting sort algorithm here
  func sortColors(_ nums: inout [Int]) {
    var counts = [Int](repeating: 0, count: 3)

    for num in nums {
      counts[num] += 1
    }

    var res = [Int]()
    for (num, count) in counts.enumerated() {
      res += Array(repeating: num, count: count)
    }

    nums = res
  }

  // 1456. Maximum Number of Vowels in a Substring of Given Length
  // Using sliding window keep window of size k, and keep track of
  // current count of vowels every time window expands and shrinks
  func maxVowels(_ s: String, _ k: Int) -> Int {
    // == is faster than checking a set
    func isVowel(_ char: Character) -> Bool {
      char == "a" || char == "e" ||
      char == "i" || char == "o" ||
      char == "u"
    }

    let string = Array(s)
    var left = 0
    var ans = 0
    var curr = 0

    for right in string.indices {
      if isVowel(string[right]) {
        curr += 1
      }

      if right - left >= k {
        if isVowel(string[left]) {
          curr -= 1
        }
        left += 1
      }

      ans = max(ans, curr)
    }

    return ans
  }

  // 1208. Get Equal Substrings Within Budget
  func equalSubstring(_ s: String, _ t: String, _ maxCost: Int) -> Int {
    let first = Array(s)
    let second = Array(t)

    var currCredit = maxCost
    var left = 0
    var ans = 0

    for right in first.indices {
      currCredit -= abs(Int(first[right].asciiValue!) -  Int(second[right].asciiValue!))

      while currCredit < 0 {
        currCredit += abs(Int(first[left].asciiValue!) -  Int(second[left].asciiValue!))
        left += 1
      }

      ans = max(ans, right - left + 1)
    }

    return ans
  }

  // 209. Minimum Size Subarray Sum
  func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
    var left = 0
    var ans = Int.max
    var curr = 0

    for right in nums.indices {
      curr += nums[right]

      while curr - nums[left] >= target {
        curr -= nums[left]
        left += 1
      }

      if curr >= target {
        ans = min(ans, right - left + 1)
      }
    }

    return ans == Int.max ? 0 : ans
  }

  // 12. Fizz Buzz
  func fizzBuzz(_ n: Int) -> [String] {
    var res = [String]()
    res.reserveCapacity(n)

    for i in 1...n {
      if i % 3 == 0 && i % 5 == 0 {
        res.append("FizzBuzz")
      } else if i % 3 == 0 {
        res.append("Fizz")
      } else if i % 5 == 0 {
        res.append("Buzz")
      } else {
        res.append(String(i))
      }
    }

    return res
  }
}
