class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.password_reset.subject
  #
  def password_reset
    mail to: params[:user].email
  end
end
