import Foundation
import Solution

extension Solution {
  func checkIfPangram(_ sentence: String) -> Bool {
    var alphabet = Set("abcdefghijklmnopqrstuvwxyz")
    for char in sentence {
      alphabet.remove(char)
    }
    return alphabet.isEmpty
  }

  func missingNumber(_ nums: [Int]) -> Int {
    let numsSet = Set(nums)

    for num in 0...nums.count {
      if !numsSet.contains(num) {
        return num
      }
    }

    fatalError("Nums have all characters.")
  }

  func countElements(_ arr: [Int]) -> Int {
    let set = Set(arr)
    var res = 0

    for num in arr {
      if set.contains(num + 1) {
        res += 1
      }
    }

    return res
  }

  /// 560. Subarray Sum Equals K
  /// Given an integer array nums and an integer k, find the number of subarrays
  /// whose sum is equal to k.
  func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    var ans = 0

    // Represent how much time given prefix sum occurred.
    // Empty prefix sum occurred ones, that means 0 sum occurred ones for []
    // key represents prefix sum and value is how much times it appeared.
    var counts: [Int: Int] = [0: 1]
    // Represents current prefix sum
    var curr = 0

    for n in nums {
      curr += n
      // curr - x = k => x = curr - k where x is
      // prefix sum of any subarray and value for
      // this prefix sum represents coun of subarrays
      // whose sum is equal to k
      ans += counts[curr - k, default: 0]

      // if we recorded `curr` prefix sum occurrence already,
      // increment it, otherwise set it occurred ones
      counts[curr, default: 0] += 1
    }

    return ans
  }

  /// 1248. Count Number of Nice Subarrays
  /// Given an array of integers nums and an integer k.
  /// A continuous subarray is called nice if there are k odd numbers on it.
  /// Return the number of nice sub-arrays.
  func numberOfSubarrays(_ nums: [Int], _ k: Int) -> Int {
    var ans = 0
    var counts: [Int: Int] = [0: 1]
    var curr = 0

    for n in nums {
      curr += n % 2
      ans += counts[curr - k, default: 0]
      counts[curr, default: 0] += 1
    }

    return ans
  }

  func findWinners(_ matches: [[Int]]) -> [[Int]] {
    var lostCounts: [Int: Int] = [:]
    for match in matches {
      let winner = match[0]
      let looser = match[1]

      lostCounts[winner, default: 0] += 0
      lostCounts[looser, default: 0] += 1
    }

    var lostOnes = [Int]()
    var noLoses = [Int]()

    for (player, looses) in lostCounts {
      if looses == 0 {
        noLoses.append(player)
      } else if looses == 1 {
        lostOnes.append(player)
      }
    }

    return [noLoses.sorted(), lostOnes.sorted()]
  }

  func largestUniqueNumber(_ nums: [Int]) -> Int {
    // key - number, value - count of occurrenses
    var occurrences: [Int: Int] = [:]
    for num in nums {
      occurrences[num, default: 0] += 1
    }

    for (num, count) in occurrences {
      if count > 1 {
        occurrences.removeValue(forKey: num)
      }
    }

    return occurrences.keys.max() ?? -1
  }

  func maxNumberOfBalloons(_ text: String) -> Int {
    let set = Set("balloon")
    var counts: [Character: Int] = [:]

    for char in text.lowercased() where set.contains(char) {
      counts[char, default: 0] += 1
    }

    guard set == Set(counts.keys) else {
      return 0
    }

    counts["l", default: 0] /= 2
    counts["o", default: 0] /= 2

    return counts.values.min() ?? 0
  }

  /// 49. Group Anagrams
  /// Given an array of strings strs, group the anagrams
  /// together. You can return the answer in any order.
  func groupAnagrams(_ strs: [String]) -> [[String]] {
    var anagrams: [[Character]: [String]] = [:]
    for str in strs {
      anagrams[str.sorted(), default: []].append(str)
    }
    return Array(anagrams.values)
  }

  /// 2260. Minimum Consecutive Cards to Pick Up
  /// You are given an integer array cards where cards[i]
  /// represents the value of the ith card. A pair of cards are
  /// matching if the cards have the same value.
  /// Return the minimum number of consecutive cards you
  /// have to pick up to have a pair of matching cards among
  /// the picked cards. If it is impossible to have matching cards,
  /// return -1.
  func minimumCardPickup(_ cards: [Int]) -> Int {
    // key - card
    // value - last stored index for a given card
    var diffs: [Int: Int] = [:]
    var ans = Int.max

    for index in cards.indices {
      if let lastStoredIndex = diffs[cards[index]] {
        ans = min(ans, index - lastStoredIndex + 1)
      }
      diffs[cards[index]] = index
    }

    return ans == Int.max ? -1 : ans
  }

  /// 2342. Max Sum of a Pair With Equal Sum of Digits
  /// You are given a 0-indexed array nums consisting of positive integers.
  /// You can choose two indices i and j, such that i != j, and the sum of
  /// digits of the number nums[i] is equal to that of nums[j]. Return
  /// the maximum value of nums[i] + nums[j] that you can obtain over
  /// all possible indices i and j that satisfy the conditions.
  func maximumSum(_ nums: [Int]) -> Int {
    var numberDigestSum: [Int: Int] = [:]
    var ans = -1

    for num in nums {
      var sum = 0
      var n = num
      while n != 0 {
        sum += n % 10
        n /= 10
      }

      if let maxNum = numberDigestSum[sum] {
        ans = max(ans, maxNum + num)
        numberDigestSum[sum] = max(maxNum, num)
      } else {
        numberDigestSum[sum] = num
      }
    }

    return ans
  }

  /// 2352. Equal Row and Column Pairs
  /// Given a 0-indexed n x n integer matrix grid, return the number
  /// of pairs (ri, cj) such that row ri and column cj are equal.
  func equalPairs(_ grid: [[Int]]) -> Int {
    // key - column
    // value - count of such columns
    var columnsCount: [[Int]: Int] = [:]
    for colIndex in 0..<grid.count {
      var column: [Int] = []
      for rowIndex in 0..<grid.count {
        column.append(grid[rowIndex][colIndex])
      }
      columnsCount[column, default: 0] += 1
    }

    var ans = 0
    for row in grid {
      ans += columnsCount[row, default: 0]
    }

    return ans
  }

  /// 383. Ransom Note
  /// Given two strings ransomNote and magazine, return true if ransomNote
  /// can be constructed by using the letters from magazine and false otherwise.
  func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    // key - letter in the magazine
    // value - how much letter of this type we have/used
    var letters: [Character: Int] = [:]
    // resolve letters availability
    for char in magazine {
      letters[char, default: 0] += 1
    }
    // resolve letters usage
    for char in ransomNote {
      letters[char, default: 0] -= 1
    }
    // should have at lest 0 or more letters available,
    // means we used all of them or we have spare left
    return letters.values.min() ?? 0 >= 0
  }

  /// 771. Jewels and Stones
  /// You're given strings jewels representing the types of stones that are jewels,
  /// and stones representing the stones you have. Each character in stones is
  /// a type of stone you have. You want to know how many of the stones you
  /// have are also jewels.
  func numJewelsInStones(_ jewels: String, _ stones: String) -> Int {
    var ans = 0
    for stone in stones {
      if jewels.contains(stone) {
        ans += 1
      }
    }
    return ans
  }

  /// 3. Longest Substring Without Repeating Characters
  /// Given a string s, find the length of the longest substring
  /// without repeating characters.
  func lengthOfLongestSubstring(_ s: String) -> Int {
    guard !s.isEmpty else { return 0 }

    var chars: [Character: String.Index] = [:]
    var left = s.startIndex
    var ans = 0

    for (char, right) in zip(s, s.indices) {
      if let lastIndex = chars[char], lastIndex >= left {
        left = s.index(after: lastIndex)
      }
      chars[char] = right
      ans = max(ans, s[left...right].count)
    }

    return ans
  }

  /// 1436. Destination City
  func destCity(_ paths: [[String]]) -> String {
    var from = Set<String>()
    var to = Set<String>()

    for trip in paths {
      from.insert(trip[0])
      to.insert(trip[1])
    }

    return to.subtracting(from).first ?? "unknown"
  }

  /// 1496. Path Crossing
  func isPathCrossing(_ path: String) -> Bool {
    var visited = Set<String>()
    var x = 0
    var y = 0
    visited.insert("\(x),\(y)")

    for direction in path {
      switch direction {
      case "N": y += 1
      case "S": y -= 1
      case "E": x += 1
      case "W": x -= 1
      default: fatalError("Unknown direction.")
      }

      if visited.contains("\(x),\(y)") {
        return true
      } else {
        visited.insert("\(x),\(y)")
      }
    }

    return false
  }

  func sumOfUnique(_ nums: [Int]) -> Int {
    var counts: [Int: Int] = [:]
    for num in nums {
      counts[num, default: 0] += 1
    }

    var ans = 0
    for (num, count) in counts where count == 1 {
      ans += num
    }
    return ans
  }

  func maxFrequencyElements(_ nums: [Int]) -> Int {
    var counts: [Int: Int] = [:]
    for num in nums {
      counts[num, default: 0] += 1
    }

    if let maxFrequency = counts.values.max() {
      var ans = 0
      for (num, frequency) in counts where frequency == maxFrequency {
        ans += num * frequency
      }
      return ans

    } else {
      return 0
    }
  }

  func findLucky(_ arr: [Int]) -> Int {
    var frequencies = [Int: Int]()
    for num in arr {
      frequencies[num, default: 0] += 1
    }

    var ans = -1
    for (num, frequency) in frequencies where num == frequency {
      ans = max(ans, num)
    }

    return ans
  }
}
