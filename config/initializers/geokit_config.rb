# frozen_string_literal: true

# These defaults are used in Geokit::Mappable.distance_to and acts_as_mappable
Geokit.default_units = :kms # others :kms, :nms, :meters
Geokit.default_formula = :sphere

# This is the timeout value in seconds to be used for calls to the geocoder web
# services.  For no timeout at all, comment out the setting.  The timeout unit
# is in seconds.
Geokit::Geocoders.request_timeout = 3
