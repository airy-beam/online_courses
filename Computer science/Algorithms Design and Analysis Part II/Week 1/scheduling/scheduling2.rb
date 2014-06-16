file = File.new("jobs.txt", "r")
jobs_count = file.gets.to_i

jobs = Array.new
0.upto(jobs_count - 1) { |i|
  line = file.gets.split
  weight, length = line[0].to_i, line[1].to_i
  jobs[i] = Array.new
  jobs[i][0], jobs[i][1], jobs[i][2] = weight, length, weight.to_f / length.to_f
}

jobs.sort! { |a,b| b[2] <=> a[2] }
#0.upto(jobs_count - 1) { |i| print jobs[i][0], " ", jobs[i][1], " ", jobs[i][2] ,"\n" }

completion_times = Array.new
completion_times[0] = jobs[0][1]
1.upto(jobs_count - 1) { |i| completion_times[i] = completion_times[i - 1] + jobs[i][1] }
sum_weighted_completion_times = 0
0.upto(jobs_count - 1) { |i| sum_weighted_completion_times += completion_times[ i ] * jobs[i][0] }
print sum_weighted_completion_times