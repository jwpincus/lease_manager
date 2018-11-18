class Financials

  def initialize(user)
    @user = user
  end

  def leases_by_year
    @user.leases.map { |l| l.revenue_by_all_months  }
  end

  # This is a code smell if I've ever seen one. woof
  def totals_by_month_year
    revenue = Hash.new { |hash, key| hash[key] = {} }
    leases_by_year.each do |lease|
      lease.each do |year, months|
        months.each do |month, rent|
          revenue[year][month] ? revenue[year][month] += rent : revenue[year][month] = rent
        end
      end
    end
    revenue
  end



end
# Owners and Managers can view a financial dashboard by calendar year:
#     • For each month in that calendar year, they see a summary of the rent collected or to be collected in that month, and they can filter by lease or see a total across all leases.
