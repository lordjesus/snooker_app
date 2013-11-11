class UserMailer < ActionMailer::Base
  default from: "tilmelding@snooker.dk"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user  
    mail(to: user.email, subject: "Nulstilling af password")
  end

  def user_created(user)
    @user = user
    mail(to: user.email, subject: "Profil oprettet")
  end
end
