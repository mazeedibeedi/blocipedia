require 'amount'
include Amount
class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Upgrade to Premium Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Upgrading to Premium Account - #{current_user.email}",
      currency: 'usd'
    )
    current_user.premium!
    flash[:notice] = "You have now successfully upgraded to the premium account!"
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end
end
