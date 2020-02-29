
#   Random number return with base probability
def random_number_by_probability options
	current, max = 0, options.values.inject(:+)
	random_value = rand(max) + 1
	options.each do |key, val|
		current += val
		return key if random_value <= current
	end
end