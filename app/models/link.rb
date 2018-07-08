require 'uri'

class UrlValidator < ActiveModel::Validator
  def validate(record)
    uri = URI.parse(record.long_url)
    mark_url_as_invalid(record) unless http_uri?(uri)
  rescue URI::InvalidURIError
    mark_url_as_invalid(record)
  end

  private

  def http_uri?(uri)
    uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
  end

  def mark_url_as_invalid(record)
    record.errors[:base] << "This url is not valid"
  end
end

class Link < ApplicationRecord
  validates_with UrlValidator

  has_secure_token :short_url
end
