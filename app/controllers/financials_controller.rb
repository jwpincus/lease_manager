class FinancialsController < ApplicationController
  before_action :manager_or_owner_auth

  def index
    @financials = Financials.new(current_user)
  end

  def show
    @lease = current_user.leases.find_by_id(params[:id])
  end

  private

  def manager_or_owner_auth
    redirect_to root_path if !current_user || current_user.tenant?
  end

end
