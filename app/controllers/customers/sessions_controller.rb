# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   debugger
  #     if customer = Customer.where("email LIKE ?", "%#{ params[:customer][:email] }").first
  #       unless customer.is_active
  #         session.clear
  #         flash.notice = "退会済み"
  #         new_customer_session_path
  #       end
  #     end
  #     super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  def after_sign_in_path_for(resource)
    unless current_customer.is_active
      @customer = current_customer
      session.clear
      flash.notice = "退会済み"
      new_customer_session_path
    else
      items_path
    end
  end

  def after_sign_out_path_for(resource)
    items_path
  end
end
