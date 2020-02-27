require File.expand_path 'lib/models/people'
require File.expand_path 'lib/models/operator'
require File.expand_path 'lib/helpers/sort_timer'

$THREADS = []
$CLIENTS = []
operator_1 = Operator.new
$ORDER = 0


def execute(operator_1, last_time_arrival)
	time_of_processing = sort_time_of_processing()
	
	$ORDER += 1
	people_in = People.new $ORDER, last_time_arrival, time_of_processing
	puts "* Arrival new client #{$ORDER} (service: #{time_of_processing})\n"
	$CLIENTS << people_in
	operator_1.push_queue(people_in)
end

system('clear')
puts "---- Operator bank information service ---- \n"
puts "Time now: #{Time.now} -> #{Time.now.to_i} Initial service\n\n"

40.times.map {
	last_time_arrival = sort_last_time_arrival()
	puts "(i): Next client in #{last_time_arrival}\n"
	sleep(last_time_arrival)
	$THREADS << Thread.new { execute(operator_1, last_time_arrival) }
}

$THREADS.each(&:join)

$CLIENTS.each { |pp| 
	puts "\n\n\t| order: #{pp.number}"
	puts "\t| time arrival: #{pp.time_arrival}"
	puts "\t| time of processing: #{pp.time_of_processing}"
	puts "\t| initial service: #{pp.initial_service}"
	puts "\t| end service: #{pp.end_service}"
	puts "\t| waiting time: #{pp.waiting_time}"
	puts "\t| total time: #{pp.total_time}"
	puts "\t| last time arrival: #{pp.last_time_arrival}"
}

puts "\n\n Operator resume:"
puts "Time in hidle: #{operator_1.time_in_hidle}"
puts "Time in service: #{operator_1.start_service - operator_1.time_in_hidle}"