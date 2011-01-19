require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new
scheduler.cron '0 22 * * 0-6' do
  # every day of the week at 22:00 (10pm)
  puts Time.now
end
#cron格式：
#第1列分钟1～59
#第2列小时1～23（0表示子夜）
#第3列日1～31
#第4列月1～12
#第5列星期0～6（0表示星期天）
#第6列要运行的命令