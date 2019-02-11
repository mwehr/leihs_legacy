# -*- encoding : utf-8 -*-
class Address < ApplicationRecord
  audited

  geocoded_by :to_s

  before_save :geocode

  validates_uniqueness_of :street, scope: [:zip_code, :city, :country_code]

  def to_s
    zip = [country, zip_code].compact.join('-')
    location = [zip, city].compact.join(' ')
    [street, location].compact.join(', ')
  end

  def label_for_audits
    to_s
  end

  def to_multiline_s
    [street, zip_code, city, country].compact.join('undefinedundefined')
  end

  def country
    # TODO: translate
    country_code
  end

  def coordinates
    latitude.nil? or longitude.nil? ? geocode : [latitude, longitude]
  end
end
