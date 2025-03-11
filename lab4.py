import math

# Given data
radius_earth = 6371  # Earth's radius in km
height_satellite = 35786  # Satellite height above Earth's surface in km
latitude_station = 40  # Latitude of ground station in degrees
longitude_station = 13  # Longitude of ground station in degrees
longitude_satellite = 39  # Longitude of satellite in degrees

# Convert degrees to radians
latitude_station_rad = math.radians(latitude_station)
delta_longitude_rad = math.radians(abs(longitude_satellite - longitude_station))

# Calculate the angular distance (theta)
theta = math.acos(math.cos(delta_longitude_rad) * math.cos(latitude_station_rad))

# Calculate the distance
distance = radius_earth * math.sqrt(
    1 + (height_satellite / radius_earth) ** 2 - 2 * (height_satellite / radius_earth) * math.cos(theta)
)

print(distance)