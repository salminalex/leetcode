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
}
