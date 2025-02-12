namespace :post_deploy_migration do
  desc "Fetch city and zipcode for old users"
  task backfill_user_geo: :environment do
    User.where(geo_context: nil).where.not(address_ciphertext: nil).find_each do |user|
      GeocodeUserJob.perform_later(user.id)
    end
  end
end
