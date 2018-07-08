require 'uri'

class UrlValidator < ActiveModel::Validator
  def validate(record)
    begin
      uri= URI.parse(record.long_url)
      unless uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
        record.errors[:base] << "This url is not valid"
      end
    rescue URI::InvalidURIError
      record.errors[:base] << "This url is not valid"
    end
  end
end


class Link < ApplicationRecord
  validates_with UrlValidator

  has_secure_token :short_url
end
