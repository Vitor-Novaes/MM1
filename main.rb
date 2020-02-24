require File.expand_path 'lib/models/people'
require File.expand_path 'lib/models/operator'
require File.expand_path 'lib/helpers/sort_timer'
require 'thread'
semaphore = Mutex.new

operator_1 = Operator.new
$ORDER = 0

threads = 20.times.map {
	Thread.new{
		semaphore.synchronize {
			last_time_arrival = sort_last_time_arrival()
			time_of_processing = sort_time_of_processing()

			sleep(last_time_arrival)
			$ORDER += 1
			People.new $ORDER, last_time_arrival, time_of_processing
			operator_1.push_queue(people_in)
		}
	}
}


