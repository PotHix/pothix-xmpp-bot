DaemonKit::Application.running!

require 'blather/client'

@config = DaemonKit::Config.load('xmpp')
setup @config.jabber_id, @config.password

send_to = Blather::JID.new @config["masters"].first

subscription :request? do |s|
  write_to_stream s.approve!
end

message :chat?, :body do |m|
  DaemonKit.logger.info "Message: #{m.body}"
  say send_to, m.body
end

when_ready do
  DaemonKit.logger.info "Connected #{jid}"

  subs = Blather::Stanza::Presence::Subscription.new send_to, :subscribe
  write_to_stream subs.request!

  say send_to, "You shall not pass!"
end
