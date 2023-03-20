class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@email.com'
  layout 'mailer'
end
