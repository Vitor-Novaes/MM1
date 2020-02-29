require File.expand_path 'lib/helpers/picker'

$TIME_LAST_ARRIVAL_PROBABILITY = { '6' => 60, '7' => 20, '8' => 20 } # { number: probability }
$TIME_OF_PROCESSING = { '9' => 10, '10' => 10, '15' => 80 } # { number: probability }

def sort_last_time_arrival
	last_time_arrival = random_number_by_probability($TIME_LAST_ARRIVAL_PROBABILITY).to_i
end

def sort_time_of_processing
	time_of_processing = random_number_by_probability($TIME_OF_PROCESSING).to_i
end