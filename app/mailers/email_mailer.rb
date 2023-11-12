class EmailMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.email_mailer.email_confirmation.subject
  #
  def email_confirmation
    mail to: params[:user].email
  end
end
