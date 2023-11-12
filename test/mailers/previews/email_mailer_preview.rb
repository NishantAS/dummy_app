# Preview all emails at http://localhost:3000/rails/mailers/email_mailer
class EmailMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/email_mailer/email_confirmation
  def email_confirmation
    EmailMailer.email_confirmation
  end

end
