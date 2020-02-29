
# require 'thread'
# mutex = Mutex.new
# $operator = false
# $THREADS = []

# def execute
#     $operator = true
#     puts "\n\nprocess..."
#     puts $operator
#     sleep(5)
#     $operator = false
#     puts $operator
#     puts "end\n\n"
# end

# 3.times.map {
#     sleep(2)
# 	$THREADS << Thread.new { 
#         if !$operator
#             execute()
#         else
#             puts "\n\nOperator true"
#             puts $operator
#         end
#     }
# }
# $THREADS.each(&:join)
teste = 3
for i in 1..teste  do
    puts 'ola'
end