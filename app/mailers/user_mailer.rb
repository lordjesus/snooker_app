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

  def user_activated(user) 
    @user = user
    mail(to: user.email, subject: "Profil aktiveret")
  end

  def user_joined_tournament(user, tournament)
    @user = user
    @tournament = tournament
    mail(to: user.email, subject "Tilmelding til #{tournament.name}")
  end

  def user_left_tournament(user, tournament)
    @user = user
    @tournament = tournament
    mail(to: user.email, subject "Afmelding af #{tournament.name}")
  end
end
