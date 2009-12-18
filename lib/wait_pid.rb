
class WaitPid

  def self.wait_pid(pid, test = false)
    # initial test
    count = 0
    begin
      loop { Process.kill( 0, pid); count += 1; sleep 0.01}
    rescue Errno::ESRCH
      if count == 0
        if test
          return "non existing"
        else
          puts "warning: pid not found #{pid}" if $VERBOSE
        end
      else
        # normal
      end
    end

  end

end