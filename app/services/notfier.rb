class Notifier

  # call this class froma scheduled rake task or other jobs scheduler using Notifier.notify_daily

  def self.notify_daily!
    notify_rent_due
    notify_lease_expiratons
  end

  def self.notify_rent_due
    Lease.where(payment_day_this_month: Date.today.day).each do |lease|
      # Mailer.rent_due_notification(lease).deliver_now
    end
  end
  def self.notify_lease_expiratons
    Lease.where(ends_at: Date.today + 2.months).each do |lease|
      # Mailer.lease_expiration_notification(lease).deliver_now
    end
  end

end
