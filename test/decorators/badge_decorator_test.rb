require 'test_helper'

class BadgeDecoratorTest < ActiveSupport::TestCase
  describe 'KudoRankBadge' do
    let(:account) { create(:account) }
    let(:kudo_badge) { BadgeDecorator.new(KudoRankBadge.new(account)) }
    let(:request) { stub(protocol: 'http://', host_with_port: 'test.host') }

    it 'should do return the image URL' do
      kudo_badge.image_url(request).wont_be_empty
      kudo_badge.image_url(request).must_equal 'http://test.host/images/badges/kudo_rank.png'
    end

    it 'should do return the css_class' do
      kudo_badge.css_class(1, 'small', 4).wont_be_empty
      kudo_badge.css_class(1, 'small', 4).must_equal 'kudo-rank-badge'
    end

    it 'should return the pips url' do
      kudo_badge.pips_url(request).wont_be_empty
      kudo_badge.pips_url(request).must_equal 'http://test.host/images/badges/pips_01.png'
    end
  end
end