require File.expand_path 'lib/helpers/picker'

$TIME_LAST_ARRIVAL_PROBABILITY = { '10' => 35, '12' => 40, '14' => 25 } # { number: probability }
$TIME_OF_PROCESSING = { '9' => 30, '10' => 50, '11' => 20 } # { number: probability }

def sort_last_time_arrival
	last_time_arrival = random_number_by_probability($TIME_LAST_ARRIVAL_PROBABILITY).to_i
end

def sort_time_of_processing
	time_of_processing = random_number_by_probability($TIME_OF_PROCESSING).to_i
end