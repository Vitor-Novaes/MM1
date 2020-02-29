require 'thread'
semaphore = Mutex.new
threads = []

$operator = false

def test(s, i)
  p "enter test #{i}"
  sleep(1)
  p "enter syncro #{i}"
  $operator = true
  sleep(1)
  $operator = false
  sleep(1)
  p "exiting test #{i}"
end

threads << Thread.new {
  test(semaphore, 1)
  sleep(3)
  p "exiting thread 1"
}

threads << Thread.new {
  sleep(2)
  loop do
    if !$operator
      puts "Executed because $operator is #{$operator}"
      test(semaphore, 2)
      break
    else
      puts 'Busy'
      sleep(1)
    end
  end
  sleep(3)
  p "exiting thread 2"
}

threads.each {|t| t.join}