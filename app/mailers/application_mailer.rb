# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@target.com'
  layout 'mailer'
end
