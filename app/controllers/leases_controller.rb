class LeasesController < ApplicationController
  
  def new
    redirect_to root_path if !current_user || !current_user.role == 'owner'
  end
  
  def create
    lease = current_user.leases.create(lease_params)
    if lease
      flash['success'] = "New lease succesfully created"
      redirect_to lease_path(lease) 
    else
      flash[:danger] = lease.errors.full_messages.join(", ")
      redirect_back
    end
  end
  
  def show
    @lease = Lease.find(params[:id])
  end
  
  private
  
  def lease_params
    params.require(:lease).permit(
     :amount,
     :starts_at,
     :ends_at,
     :address_line_1,
     :address_line_2,
     :payment_day,
     :zip,
     :city,
     :state)
  end
  
end
