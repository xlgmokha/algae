description = <<-DOC
Note: Write a solution with O(n2) time complexity, since this is what you would be asked to do during a real interview.

You have an array a composed of exactly n elements. Given a number x, determine whether or not a contains three elements for which the sum is exactly x.

Example

For x = 15 and a = [14, 1, 2, 3, 8, 15, 3], the output should be
tripletSum(x, a) = false;

For x = 8 and a = [1, 1, 2, 5, 3], the output should be
tripletSum(x, a) = true.

The given array contains the elements 1,2, and 5, which add up to 8.

Input/Output

[time limit] 4000ms (rb)
[input] integer x

Guaranteed constraints:
1 ≤ x ≤ 3000.

[input] array.integer a

Guaranteed constraints:
3 ≤ a.length ≤ 1000,

1 ≤ a[i] ≤ 1000.

[output] boolean

Return true if the array contains three elements that add up to x and false otherwise.
DOC

describe "triplet sum" do
  def triplet_sum(target, items)
    # n + nlogn
    sorted = items.sort.find_all { |x| x < target }
    n = sorted.size
    n.times do |i|
      head = sorted[i]
      (i+1).upto(n - 1) do |j|
        middle = sorted[j]
        (j+1).upto(n - 1) do |k|
          tail = sorted[k]
          return true if target == head + middle + tail
        end
      end
    end
    false
  end

  def bsearch_index(items, target)
    n = items.size
    return (target == items[0]) ? 0 : nil if n == 1
    return 0 if n == 2 && target == items[0]
    return 1 if n == 2 && target == items[1]
    return nil if n == 2

    mid = n / 2
    result = target <=> items[mid]
    if result == 0
      return mid
    elsif result > 0
      result = bsearch_index(items[mid+1..n], target)
      return mid + result if result
    else
      result = bsearch_index(items[0..mid], target)
      return mid + result if result
    end
    nil
  end

  def triplet_sum(target, items)
    # nlogn
    sorted = items.sort
    # logn
    high_index = bsearch_index(sorted, target)
    sorted = sorted[0..high_index] if high_index
    n = sorted.size
    # n
    n.times do |i|
      head = sorted[i]
      # n - 1
      (i+1).upto(n - 1) do |j|
        middle = sorted[j]
        remaining = target - (head + middle)
        next if remaining <= 0
        next if remaining < middle
        # logn
        result = sorted[j+1..n-1].bsearch { |x| x >= remaining }
        return true if result == remaining
      end
    end
    # total: nlogn + logn + n + (n-1) + logn
    # 2logn + nlogn + 2n
    # nlogn ?
    false
  end

  #def triplet_sum(target, items)
    #items.combination(3).to_a.any? { |x| x.reduce(:+) == target }
  #end

  # Victors solution
  #def triplet_sum(target, array)
    #array.sort!
    #solution = []
    #(0..array.length - 3).each do |i|
      #next unless i == 0 || i > 0 && array[i - 1] != array[i]
      #head = i + 1
      #tail = array.length - 1
      #while head < tail
        #sum = array[i] + array[head] + array[tail]
        #if sum == target
          #solution.push([array[i], array[head], array[tail]])
          #head += 1
          #tail -= 1
          #head += 1 while head < tail && array[head] == array[head - 1]
          #tail += 1 while tail > head && array[tail] == array[tail + 1]
        #elsif sum < target
          #head += 1
        #else
          #tail -= 1
        #end
      #end
    #end
    #solution.any?
  #end

  it do
    expect(triplet_sum(15, [14, 1, 2, 3, 8, 15, 3])).to be(false)
  end

  it do
    expect(triplet_sum(8, [1, 1, 2, 5, 3])).to be(true)
  end

  [
    [15, [14, 1, 2, 3, 8, 15, 3], false],
    [8, [1, 1, 2, 5, 3], true],
    [6, [2, 3, 1], true],
    [5, [2, 3, 1], false],
    [468, [335, 501, 170, 725, 479, 359, 963, 465, 706, 146, 282, 828, 962, 492, 996, 943, 828, 437, 392, 605, 903, 154, 293, 383, 422, 717, 719, 896, 448, 727, 772, 539, 870, 913, 668, 300, 36, 895, 704, 812, 323, 334], false],
    [165, [142, 712, 254, 869, 548, 645, 663, 758, 38, 860, 724, 742, 530, 779, 317, 36, 191, 843, 289, 107, 41, 943, 265, 649, 447, 806, 891, 730, 371, 351, 7, 102, 394, 549, 630, 624, 85, 955, 757, 841, 967, 377, 932, 309, 945, 440, 627, 324, 538, 539, 119, 83, 930, 542, 834, 116, 640, 659, 705, 931, 978, 307, 674, 387, 22, 746, 925, 73, 271, 830, 778, 574, 98, 513], true],
    [1291, [162, 637, 356, 768, 656, 575, 32, 53, 351, 151, 942, 725, 967, 431, 108, 192, 8, 338, 458, 288, 754, 384, 946, 910, 210, 759, 222, 589, 423, 947, 507, 31, 414, 169, 901, 592, 763, 656, 411, 360, 625, 538, 549, 484, 596, 42, 603, 351, 292, 837, 375, 21, 597, 22, 349, 200, 669, 485, 282, 735, 54, 1000, 419, 939, 901, 789, 128, 468, 729, 894, 649, 484, 808, 422, 311, 618, 814, 515, 310, 617, 936, 452, 601, 250, 520, 557, 799, 304, 225, 9, 845, 610, 990, 703, 196, 486, 94, 344, 524, 588, 315, 504, 449, 201, 459, 619, 581, 797, 799, 282, 590, 799, 10, 158, 473, 623, 539, 293, 39, 180, 191, 658, 959, 192, 816, 889, 157, 512, 203, 635, 273, 56, 329, 647, 363, 887, 876, 434, 870, 143, 845, 417, 882, 999, 323, 652, 22, 700, 558, 477, 893, 390, 76, 713, 601, 511, 4, 870, 862, 689, 402, 790, 256, 424, 3, 586, 183, 286, 89, 427, 618, 758, 833, 933, 170, 155, 722, 190, 977, 330, 369, 693, 426, 556, 435, 550, 442], true],
    # 19, 24, 103
    [146, [61, 719, 754, 140, 424, 280, 997, 688, 530, 550, 438, 867, 950, 194, 196, 298, 417, 287, 106, 489, 283, 456, 735, 115, 702, 317, 672, 787, 264, 314, 356, 186, 54, 913, 809, 833, 946, 314, 757, 322, 559, 647, 983, 482, 145, 197, 223, 130, 162, 536, 451, 174, 467, 45, 660, 293, 440, 254, 25, 155, 511, 746, 650, 187, 314, 475, 23, 169, 19, 788, 906, 959, 392, 203, 626, 478, 415, 315, 825, 335, 875, 373, 160, 834, 71, 488, 298, 519, 178, 774, 271, 764, 669, 193, 986, 103, 481, 214, 628, 803, 100, 528, 626, 544, 925, 24, 973, 62, 182, 4, 433, 506, 594], true],
    [1032, [493, 143, 223, 287, 65, 901, 188, 361, 414, 975, 271, 171, 236, 834, 712, 761, 897, 668, 286, 551, 141, 695, 696, 625, 20, 126, 577, 695, 659, 303, 372, 467, 679, 594, 852, 485, 19, 465, 120, 153, 801, 88, 61, 927, 11, 758, 171, 316, 577, 228, 44, 759, 165, 110, 883, 87, 566, 488, 578, 475, 626, 628, 630, 929, 424, 521, 903, 963, 124, 597, 738, 262, 196, 526, 265, 261, 203, 117, 31, 327, 12, 772, 412, 548, 154, 521, 791, 925, 189, 764, 941, 852, 663, 830, 901, 714, 959, 579, 366, 8, 478, 201, 59, 440, 304, 761, 358, 325, 478, 109, 114, 888, 802, 851, 461, 429, 994, 385, 406, 541, 112, 705, 836, 357, 73, 351], true],
    [13, [1, 4, 45, 6, 10, 8], true],
    [10, [1, 2, 4, 3, 6], true],
    [986, [557, 217, 627, 358, 527, 358, 338, 272, 870, 362, 897, 23, 618, 113, 718, 697, 586, 42, 424, 130, 230, 566, 560, 933], true],
    [1356, [54, 963, 585, 735, 655, 973, 458, 370, 533, 964, 608, 484, 912, 636, 68, 849, 676, 939, 224, 143, 755, 512, 742, 176, 460, 826, 222, 871, 627, 935, 206, 784, 851, 399, 280, 702, 194, 735, 638, 535, 557, 994, 177, 706, 963, 549, 882, 301, 414, 642, 856, 856, 143, 463, 612, 878, 425, 679, 753, 444, 297, 674, 41, 314, 876, 73, 819, 611, 18, 933, 113, 696, 170, 832, 41, 489, 686, 91, 498, 590, 991, 146, 354, 315, 652, 741, 45, 259, 336, 760, 193, 606, 265, 182, 504, 830, 776], true],
    [793, [998, 550, 557, 562, 628, 468, 542, 130, 241], false],
    [675, [602, 78, 216, 684, 214, 993, 825, 602, 393, 760, 671, 429, 28, 85], false],
    [787, [499, 971, 288, 848, 605, 504, 222, 664, 707, 364, 11, 172, 490, 241, 165, 543, 620, 914, 592, 705, 819, 233, 751, 206, 976, 540, 304, 423, 99, 248, 585, 649, 972, 865, 914, 76, 546, 713, 547, 679, 770, 263, 520, 986, 290, 945, 866, 541, 246, 509, 319, 871, 602, 324, 133, 473, 153, 88, 571, 764, 902, 104, 424, 528, 601, 970, 16, 566, 29, 544, 348, 89, 944, 638, 410, 464], true],
    [182, [589, 343, 609, 61, 222, 759, 955, 889, 147, 691, 950, 844, 431, 621, 749, 68, 537, 784, 36, 227, 186, 39, 854, 630, 225, 749, 924, 360, 258, 767, 945, 956, 319, 727, 412, 26, 356, 2, 550, 497, 585, 516, 965, 343, 76, 914, 143, 197, 949, 73], false],
    [1107, [174, 430, 405, 706, 627, 813, 376, 94, 566, 37, 737, 142, 815, 995, 257, 653, 937, 839, 483, 356, 16, 132, 231, 842, 626, 12, 638], true],
    [191, [651, 663, 635, 894, 354, 417, 453, 9, 263, 234, 455, 304, 635, 304, 257, 149, 125, 318, 214, 110, 29, 201, 81, 319, 859, 51, 156, 362, 265, 904, 677, 644, 910, 903, 562, 490, 949, 283, 654, 675, 221, 403, 924, 832, 370, 879, 260, 9, 620, 972, 4, 946, 782, 505, 393, 686, 314, 699, 590, 723, 939, 38, 411, 462, 235, 509, 962, 960, 494, 516, 270, 938, 870, 59, 701, 972, 265, 118, 216, 556, 816, 331, 40, 213, 289, 83, 955, 86, 711, 485, 775, 381, 816, 952, 542, 116, 680, 111, 899, 74, 789, 978, 133, 957, 690, 114, 9, 942, 791, 724, 364, 29, 185, 779, 201, 72, 886, 975, 72, 334, 868, 154, 296, 169, 826, 677, 630, 651, 599, 310, 694, 687, 81, 117, 250, 668, 529, 680, 865, 422, 406, 827, 817, 517, 727, 667, 88, 682, 965, 341, 687, 22, 663, 722, 65, 310, 416, 903, 874, 125, 942, 746, 763, 424, 532, 807, 269, 319, 603, 908, 308, 482, 13, 137, 631, 115, 810, 85, 557, 291, 294, 997, 153, 55, 346, 709, 249], true],
    [213, [132, 115, 440, 959, 723, 705, 996, 53, 270, 480, 239, 424, 919, 867, 660, 499, 487, 197, 463, 634, 159, 23, 147, 393, 38, 926, 648, 459, 603, 808, 99, 831, 293, 601, 279, 800, 353, 449, 883, 541, 316, 576, 763, 568, 337, 398, 419, 898, 829, 852, 817, 231, 450, 926, 659, 230, 521, 941, 561, 148, 163, 656, 676, 793, 362, 755, 399, 147, 715, 947, 189, 570, 639, 664, 76, 516, 522, 476, 616, 529, 235, 571, 906, 465, 558, 963, 162, 525, 550, 470, 331, 924], true],
    [834, [926, 911, 738, 337, 338, 279, 394, 637, 715, 165, 592, 950, 136, 506, 338, 5, 338, 624, 665, 971, 609, 569, 282, 86, 153, 374, 653, 195, 877, 827, 397, 573, 250, 641, 175, 820, 944, 612, 942, 290, 420, 566, 806, 586, 217, 451, 616, 610, 65, 167, 894, 75, 510, 301, 696, 574, 590, 162, 173, 969, 359, 32, 269, 427, 511, 423, 775, 780, 911, 553, 183, 392, 496, 765, 875, 365, 903, 256, 461, 475, 973, 822, 123, 548, 578, 790, 606, 196, 595, 951, 344, 755, 482, 13, 673, 440, 429, 913, 763, 968, 409, 416, 909, 224, 760, 435, 205, 487, 320, 959, 946, 807, 167, 701, 368, 693, 788, 533, 557, 975, 448, 22, 284, 223, 332, 377, 584, 949, 724, 983, 19, 777, 221, 112, 183, 857, 491, 926, 325, 487, 678, 970, 644, 535, 678, 669, 69, 992, 197, 784, 829], true],
    [927, [872, 698, 613, 704, 28, 409, 546, 509, 186, 239, 238, 444, 314, 502, 851, 129, 112, 651, 150, 193, 455, 870, 682, 466, 268, 714, 794, 635, 473, 973, 831, 902, 443, 178, 878, 771, 703, 365, 382, 591, 824, 238, 24, 180, 596, 170, 328, 43, 311, 183, 59, 927, 488, 671, 529, 652, 259, 214, 861, 784, 287, 743, 611, 473, 129, 435, 842, 719, 504, 868, 866, 939, 882, 258, 751, 615, 599, 459, 662, 64, 757, 808, 279, 490, 436, 366, 76, 587, 387, 834, 361, 331, 49, 929, 493, 434, 841, 767, 736, 811, 600, 838, 893, 983, 329, 353, 370, 245, 795, 609, 253, 648, 433, 536, 209, 265, 498, 244, 650, 16, 842, 190, 101, 813, 649, 524, 852, 475], true],
    [1392, [201, 855, 991, 698, 920, 781, 579, 932, 545, 341, 488, 900, 526, 484, 539, 493, 194, 253, 12, 561, 835, 841, 498, 786, 530, 541, 806, 792, 393, 211, 550, 579, 980, 972], true],
    [74, [194, 621, 498, 827, 277, 791, 583, 579, 160, 419, 490, 160, 450, 925, 73, 381, 9, 968, 209, 478, 504, 371, 608, 197, 75, 723, 612, 20, 762, 57, 891, 164, 684, 717, 933, 453, 742, 955, 814, 863, 397, 461, 616, 905, 600, 137, 681, 199, 33, 388, 585, 241, 518, 7, 671, 242, 883, 250, 524, 759, 106, 622, 96, 297, 917, 679, 179, 580, 59, 578, 751, 8, 730, 82, 996, 679, 677, 754], true],
    [1285, [566, 94, 609, 173, 244, 930, 515, 169, 56, 192, 974, 923, 749, 652, 987, 145, 447, 578, 518, 630, 917, 875, 792, 470, 913, 147, 694, 92, 816, 950, 858, 641, 53, 237, 552, 488, 227, 163, 956, 184, 395, 181, 98, 66, 66, 514, 262, 579, 79, 879, 141, 612, 948, 446, 171, 976, 490, 751, 150, 334, 866, 215, 283, 8, 433, 897, 368, 523, 883, 811, 642, 232, 188, 706, 480, 322, 539, 352, 448, 209, 647, 277, 760, 190, 423, 667, 487, 456, 29, 615, 861, 254, 778, 349, 504, 862, 432, 83, 456, 198], true],
    [1253, [822, 297, 282, 22, 456, 948, 125, 319, 136, 377, 775, 860, 999, 75, 254, 923, 636, 644, 889, 154, 233, 748, 681, 927, 679, 451, 802, 962, 200, 856, 364, 717, 574, 562, 246, 474, 275, 551, 354, 182, 288, 700, 111, 644, 466, 173, 530, 982, 113, 477, 382, 248, 891, 672, 806, 373, 33, 990, 321, 166, 432, 659, 294, 207, 579, 949, 207, 172, 167, 397, 698, 21, 695, 530, 789, 110, 985, 970, 979, 618, 16, 627, 685, 169, 907, 929, 98, 119, 391, 200, 786, 487, 200, 421, 711, 272, 814, 416, 86, 319, 581, 332, 268, 388, 445, 187, 508], true],
    [1328, [75, 432, 153, 272, 269, 694, 886, 338, 312, 605, 678, 407, 769, 23, 414, 1, 543, 538, 39, 389, 356, 290, 648, 182, 94, 585, 988, 762, 494, 218, 502, 483, 448, 666, 754, 105, 85, 96, 526, 222, 965, 782, 873, 107, 657, 344, 594, 81, 81, 869, 412, 714, 969, 252, 217, 80, 769, 41, 532, 934, 780, 664, 260, 654, 937, 96, 366, 875, 721, 836, 681, 977, 456, 726, 72, 809, 560, 157, 603, 833, 906, 441, 376, 563, 886, 963, 81, 837, 798, 203, 509, 81, 341, 77, 59, 494, 741, 547, 475, 774, 98, 881, 336, 73, 401, 708, 956, 667, 142, 589, 482, 169, 316, 397, 226, 10, 13, 137, 456, 763, 44, 743, 22, 923, 513, 249, 19, 369, 718, 715, 651, 291, 336, 760, 170, 896, 304, 641, 980, 200, 106, 792, 662, 682, 653, 754, 34, 30, 988, 43, 254, 84, 421, 815, 719, 245, 64, 230, 653, 865, 770], true],
    [6, [48, 595, 488, 327, 277, 324, 541, 680, 991, 589, 711, 272, 946, 222, 471, 184, 590, 956, 979, 780, 7, 263, 136, 488, 197, 34, 89, 936, 780, 994, 791, 963, 966, 2, 106, 808, 568, 670, 135, 672, 458, 999, 546, 598, 219, 839, 845, 373, 564, 29, 265, 802, 724, 491, 605, 602, 228, 198, 693, 772, 364, 302, 364, 722, 566, 422, 446, 611, 496, 742, 23], false],
    [652, [16, 56, 394, 739, 280, 883, 609, 655, 823, 708, 246, 339, 145], false],
    [1340, [155, 605, 624, 226, 79, 725, 982, 331, 734, 224, 595, 131, 847, 988, 446, 806, 617, 751, 490, 339, 964, 136, 698, 210, 631, 225, 909, 738, 475, 921, 373, 294, 856, 735, 562, 57, 607, 185, 76, 383, 120, 742, 433, 685, 780, 280, 284, 668, 837, 126, 119, 738, 29, 120, 578, 738, 92, 557, 796, 61, 902, 794, 433, 137, 581, 876, 908, 185, 75, 720, 791, 477, 42, 352, 330, 291, 975, 73, 592, 190, 788, 491, 240, 894, 54, 64, 682, 904, 6, 177, 480], true],
    [140, [469, 999, 84, 640, 516, 622, 994, 827, 723, 839, 829, 582, 400, 979, 892, 24, 944, 835, 244, 350, 703, 708, 503, 142, 688, 347, 892, 638, 414, 401, 817, 691, 163, 936, 127, 411, 878, 383, 261, 190, 706, 875, 664, 723, 196, 567, 361, 39, 589, 812, 246, 468, 426, 868, 190, 543, 64, 548, 503, 618, 100, 24, 227, 204, 49, 52, 571, 637, 459, 968, 457, 406, 532, 963, 820, 976, 557, 532, 496, 45, 592, 804, 389, 916, 451, 320, 273, 792, 384, 134, 776, 643, 570, 301, 955, 79], true],
    [758, [334, 894, 491, 104, 751, 234, 723, 272, 612, 991, 339, 642, 259, 48, 353, 659, 480, 303, 684, 991, 3, 569, 423, 896, 136, 9, 362, 743, 195, 700, 189, 179, 43, 358, 942, 848, 470, 346, 381, 914, 965, 711, 62, 386, 74, 505, 463, 704, 103, 70, 155, 530, 553, 75, 150, 731, 245, 845, 50, 119, 66, 364, 553, 774, 471, 732, 748, 512, 870, 399, 499, 104, 353, 680, 54, 44, 523, 89, 564, 835, 851, 23, 241, 912, 493, 652, 581, 478, 617, 877, 179, 221, 616, 349, 799, 180, 636, 858, 884, 663, 903, 263, 421, 771, 23, 274, 842, 687, 889, 918, 718, 893, 699, 268, 750, 66, 390, 933, 620, 82, 4, 131, 29, 632, 590, 153, 631, 173, 865, 408, 296, 429, 682, 491, 611, 178, 72, 237, 460, 644, 841, 634, 38, 894, 631, 275, 994, 783, 204, 462, 291, 663, 308, 998, 152, 424, 891, 718, 641, 704, 567, 884, 662, 660, 246, 387, 652, 766, 602, 841, 210, 498, 284, 251, 59, 422, 176, 582, 788, 272, 288, 1000, 505, 980, 139, 701], true],
    [962, [119, 206, 541, 829, 460, 623, 399, 761, 99, 936, 482, 615, 568, 494, 597, 162, 747, 539, 671, 539, 477, 556, 918, 372, 761, 753, 759, 434, 256, 66, 727, 402, 35, 760, 394, 549, 274, 793, 194, 934, 138, 104, 691, 212, 695, 669, 628, 499, 990, 249, 880, 648, 150, 932, 670, 876, 599, 450, 437, 600, 124, 444, 732, 155, 862, 435, 386, 968, 817, 394, 705, 867, 954, 309, 224, 685, 793, 668, 49, 470, 931, 812, 815, 91, 428, 744, 605, 600, 475, 196, 507, 159, 590, 859, 810, 890, 448, 41, 819, 365, 976, 27, 90, 504, 67, 413, 841, 571, 677, 396, 642, 987, 652, 110, 188, 84, 86, 391, 251, 687, 756, 382, 129, 503, 278, 863, 425, 566, 873, 833, 886], true],
    [647, [890, 479, 884, 926, 266, 261, 46, 779, 822, 856, 521, 928, 774, 135, 252, 676, 337, 335, 2, 738, 311, 975, 591, 357, 72, 81, 936, 146, 283], true],
    [719, [574, 713, 38, 999, 906, 163, 718, 693, 540, 48, 947, 104, 232, 116, 840, 859, 830, 646, 395, 200, 646, 273, 676, 863, 73, 774], false],
    [739, [898, 543, 609, 204, 278, 126, 135, 402, 79, 383, 170, 737, 479, 940, 139, 722, 427, 664, 678, 576, 725, 982, 701, 962, 863, 3, 449, 96, 685, 17, 138, 508, 994, 285, 945, 260, 822, 59, 644, 669, 678, 120, 858, 42, 892, 265, 624, 916, 73, 930, 842, 716, 616, 537, 958, 760, 701, 453, 94, 242, 830, 449, 228, 799, 225, 325, 275, 134, 886, 39, 171, 863, 630, 85, 910, 879, 924, 86, 401, 25, 194], true],
    [413, [766, 768, 408, 678, 785, 705, 791, 835, 892, 622, 86, 735, 191, 543, 999, 87, 19, 622, 425, 598, 377, 255, 670, 109, 928, 494, 69, 367, 103, 439, 601, 820, 319, 291, 985, 340, 557, 809, 633, 479, 815, 788, 240, 75, 21, 828, 555, 989, 442, 799, 643, 3, 322, 105, 947, 57, 510, 834, 709, 762, 534, 687, 805, 386, 143, 843, 261, 162, 621, 344, 579, 188, 114, 64, 592, 935, 416, 657, 762, 13, 412, 960, 252, 739, 371, 125, 508, 8, 585, 952, 102, 490, 959, 442, 791, 14, 413, 856, 61, 94, 473, 403, 677, 544, 374, 267], true],
    [276, [529, 533, 762, 470, 504, 730, 108, 893, 452, 954, 393, 571, 520, 473, 408, 495, 506, 441, 384, 263, 410, 608, 39, 361, 472, 172, 655, 948, 515, 524, 230, 490, 767, 888, 757, 633, 471, 740, 667, 523, 284, 161, 554, 706, 92, 260, 387, 688, 630, 43, 318, 46], false],
  ].each do |test|
    it "#{test[0]} is #{test[2] ? "present" : "not preset"}" do
      expect(triplet_sum(test[0], test[1])).to be(test[2])
    end
  end

  it 'plots the time for each' do
    filename = "tmp/input.csv"
    File.unlink(filename) if File.exist?(filename)
    File.open(filename, "w") do |file|
      500.times do |n|
        total = (n + 1) * 1_000
        items = Array.new(total) { rand(total) }
        target = rand(total)
        start_time = Time.now
        triplet_sum(target, items)
        end_time = Time.now
        puts "#{items.size}: #{(end_time - start_time) * 1_000} seconds"
        file.write("#{items.size},#{(end_time - start_time) * 1_000}\n")
      end
    end
  end
end
