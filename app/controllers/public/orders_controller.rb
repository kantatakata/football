class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_cart_items, only: [:new, :confirm, :create, :error]

  def new
    @order = Order.new
  end
  
  def confirm
    @order = Order.new(order_params)
    if params[:select_address] == '0'
      @order.get_shipping_informations_from(current_customer)
    elsif params[:select_address] == '1'
      @selected_address = current_customer.addresses.find(params[:address_id])
      @order.get_shipping_informations_from(@selected_address)
    elsif params[:select_address] == '2' && (@order.postal_code =~ /\A\d{7}\z/) && @order.destination? && @order.name?
      # 処理なし
    else
      flash[:error] = '情報を正しく入力して下さい。'
      render :new
    end
  end
  
  def error
  end
  
end
