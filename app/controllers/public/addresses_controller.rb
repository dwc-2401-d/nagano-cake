class Public::AddressesController < ApplicationController

  def index
    @addressed = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.save
    redirect_to customers_addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to customers_addresses_path
  end

  def destroy
     @address = Address.find(params[:id])
     @address.destroy
     redirect_to customers_addresses_path
  end


  private

  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end

end
