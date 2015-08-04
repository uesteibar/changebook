class TransferRequestMailer < ApplicationMailer

  def transfer_request_received_mail(user, transfer_request)
    @user = user
    @transfer_request = transfer_request
    mail(to: @user.email, subject: "#{@user.username}, you have a new transfer request!")
  end
end
