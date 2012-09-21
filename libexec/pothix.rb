require 'blather/client'

setup 'pothix@gmail.com', ''

send_to = Blather::JID.new 'willian.molinari@gmail.com'

subscription :request? do |s|
  write_to_stream s.approve!
end

message :chat?, :body do |m|
  puts "resposta: #{m.body}"
end

when_ready do
  puts "Connected #{jid}"
  subs = Blather::Stanza::Presence::Subscription.new send_to, :subscribe
  write_to_stream subs.request!

  say send_to, "You shall not pass!"
end
