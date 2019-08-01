class ApplicationMailer < ActionMailer::Base
  default from: ENV['email_address']
  layout 'mailer'
end
