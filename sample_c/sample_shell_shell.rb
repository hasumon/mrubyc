while true
  suspend_task # suspend task itself
  line = gets
  if line != nil && line.size > 0
    case line.chomp
    when "quit", "exit"
      puts "exit"
    when "xmodem"
      xmodem
    when "hello"
      puts "world"
      puts $a
    else
      puts "Unknown command: #{line.chomp}, size: #{line.size}"
    end
  end
end
