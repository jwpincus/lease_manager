class LeasesController < ApplicationController
  before_action :user_signed_in?
  before_action :manager_or_owner_auth, only: [:update, :edit]

  def index
    @leases = current_user.leases
  end

  def new
    redirect_to root_path if !current_user || !current_user.role == 'owner'
  end

  def create
    @lease = current_user.leases.create(lease_params)
    if @lease
      flash['success'] = "New lease succesfully created"
      redirect_to lease_path(@lease)
    else
      flash[:danger] = @lease.errors.full_messages.join(", ")
      redirect_back
    end
  end

  def show
    @lease = current_user.leases.find_by_id(params[:id])
    redirect_to root_path if @lease.nil?
  end

  def edit
    redirect_to lease_path(lease) if current_user.tenant?
    @lease = current_user.leases.find_by_id(params[:id])
  end

  def update
    if params[:manager_email]
      @lease.add_user('manager', params[:manager_email])
    elsif params[:tenant_email]
      @lease.add_user('tenant', params[:tenant_email])
    else
      @lease.update(lease_params)
    end
    redirect_to lease_path(@lease)
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

  def manager_or_owner_auth
    @lease = current_user.leases.find_by_id(params[:id])
    redirect_to lease_path(@lease) if current_user.tenant?
  end

end
