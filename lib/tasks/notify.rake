namespace :notify do
  desc "TODO"
  task daily: :environment do
    Notifier.notify_daily!
  end

end
