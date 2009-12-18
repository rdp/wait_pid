require 'rubygems' if RUBY_VERSION < '1.9'
require 'spec/autorun'
require 'sane'
require_rel '../lib/wait_pid'


def spawn command # should return a pid
 if RUBY_VERSION < '1.9'
   if OS.linux?
     fork { system(command) }
   else
     raise 'todo'
   end
 else
   Process.spawn command
 end
end

describe "wait pid" do

  it "should warn if a pid doesn't exist" do
    out = WaitPid.wait_pid 1234, true
    out.should be_a(String)
  end

  it "should work without a second argument" do
    WaitPid.wait_pid 1234
  end

  it "should wait on a pid" do
    a = spawn 'ruby -e "sleep 1"'
    Thread.new { Process.wait a } # gotta wait for it, or, as child, it never "really" ends in terms of sig 0
    start = Time.now
    WaitPid.wait_pid(a)
    assert(Time.now - start > 0.5)
  end

  it "should work on windows and linux"
  it "should use the spiffy way on windows"
  it "should poll on linux"

end
