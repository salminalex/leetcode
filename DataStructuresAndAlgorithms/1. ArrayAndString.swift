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
}
