every 2.hours do
  rake "thinking_sphinx:index"
end

every :reboot do
  rake "thinking_sphinx:start"
end

every :sunday, :at => "2am" do
  command "rm -rf #{RAILS_ROOT}/tmp/cache"
end
