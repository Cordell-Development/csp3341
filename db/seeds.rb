# Test users
admin = User.find_or_create_by!(email_address: "admin@example.com") do |user|
    user.password = "password"
    user.role = :admin
end
guest = User.find_or_create_by!(email_address: "guest@example.com") do |user|
    user.password = "password"
end

# Batch seed location data from geonames cities15000.zip dataset for speed
BATCH_SIZE = 1000
LOCATIONS_FILE = Rails.root.join("db", "seeds", "locations.txt")
now = Time.current
batch = []
File.foreach(LOCATIONS_FILE) do |line|
  fields = line.chomp.split("\t", -1)
  name, lat, lon, cc = fields[1], fields[4], fields[5], fields[8]

  # Ensure required fields are present
  next if name.blank? || lat.blank? || lon.blank?

  batch << {
    city_name: cc.present? ? "#{name}, #{cc}" : name,
    latitude: lat.to_f,
    longitude: lon.to_f,
    blacklisted: false,
    created_at: now,
    updated_at: now
  }

  if batch.size >= BATCH_SIZE
    Location.upsert_all(batch, unique_by: [ :latitude, :longitude ])
    batch.clear
  end
end

Location.upsert_all(batch, unique_by: [ :latitude, :longitude ]) unless batch.empty?

# Save some sample cities for demonstration
[ admin, guest ].each do |user|
  SavedLocation.find_or_create_by!(user: user, location: Location.find_by!(city_name: "Perth, AU"))
  SavedLocation.find_or_create_by!(user: user, location: Location.find_by!(city_name: "Melbourne, AU"))
end
