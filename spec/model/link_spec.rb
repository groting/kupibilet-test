require 'rails_helper'

RSpec.describe Link, type: :model do

  subject { Link.new(long_url: 'http://ruby-doc.com/') }

  it { should have_db_index   :long_url }
  it { should have_db_index   :short_url }

  describe '#valid?' do

    it 'return true if link is valid' do
      expect(Link.find_or_create_by(long_url: 'http://ruby-doc.com/').valid?).to  be true
    end

    it 'returne false if link is not valid URI' do
      expect(Link.find_or_create_by(long_url: 'veRyVerYbAdLiNk').valid?).to be false 
    end

    it 'returne false if long_url is empty' do
      expect(Link.find_or_create_by(long_url: nil).valid?).to be false 
    end
  end
end
