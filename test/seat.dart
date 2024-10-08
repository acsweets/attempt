//请你设计一个管理 n 个座位预约的系统，座位编号从 1 到 n 。
//
// 请你实现 SeatManager 类：
//
//
// SeatManager(int n) 初始化一个 SeatManager 对象，它管理从 1 到 n 编号的 n 个座位。所有座位初始都是可预约的。
// int reserve() 返回可以预约座位的 最小编号 ，此座位变为不可预约。
// void unreserve(int seatNumber) 将给定编号 seatNumber 对应的座位变成可以预约。
//
//
//
//
// 示例 1：
//
// 输入：
//["SeatManager", "reserve", "reserve", "unreserve", "reserve", "reserve",
//"reserve", "reserve", "unreserve"]
//[[5], [], [], [2], [], [], [], [], [5]]
//输出：
//[null, 1, 2, null, 2, 3, 4, 5, null]
//
//解释：
//SeatManager seatManager = new SeatManager(5); // 初始化 SeatManager ，有 5 个座位。
//seatManager.reserve();    // 所有座位都可以预约，所以返回最小编号的座位，也就是 1 。
//seatManager.reserve();    // 可以预约的座位为 [2,3,4,5] ，返回最小编号的座位，也就是 2 。
//seatManager.unreserve(2); // 将座位 2 变为可以预约，现在可预约的座位为 [2,3,4,5] 。
//seatManager.reserve();    // 可以预约的座位为 [2,3,4,5] ，返回最小编号的座位，也就是 2 。
//seatManager.reserve();    // 可以预约的座位为 [3,4,5] ，返回最小编号的座位，也就是 3 。
//seatManager.reserve();    // 可以预约的座位为 [4,5] ，返回最小编号的座位，也就是 4 。
//seatManager.reserve();    // 唯一可以预约的是座位 5 ，所以返回 5 。
//seatManager.unreserve(5); // 将座位 5 变为可以预约，现在可预约的座位为 [5] 。
//
//
//
//
// 提示：
//
//
// 1 <= n <= 10⁵
// 1 <= seatNumber <= n
// 每一次对 reserve 的调用，题目保证至少存在一个可以预约的座位。
// 每一次对 unreserve 的调用，题目保证 seatNumber 在调用函数前都是被预约状态。
// 对 reserve 和 unreserve 的调用 总共 不超过 10⁵ 次。
//
//
// Related Topics 设计 堆（优先队列） 👍 49 👎 0

//leetcode submit region begin(Prohibit modification and deletion)
class SeatManager {
  Map<int, bool> seats = {};

  SeatManager(int n) {
    for (int i = 1; i <= n; i++) {
      seats[i] = true;
    }
  }

  int reserve() {
    int? minKey = seats.entries
        .where((entry) => entry.value) // 筛选出 value 为 true 的条目
        .map((entry) => entry.key) // 提取 key
        .reduce((a, b) => a < b ? a : b);
    seats[minKey] = false;
    return minKey;
  }

  void unReserve(int seatNumber) {
    seats[seatNumber] = true;
  }
}

void main() {
  SeatManager s = SeatManager(10);
  print(s.reserve());
  print(s.reserve());
  print(s.reserve());
  s.unReserve(1);
  print(s.reserve());
}
