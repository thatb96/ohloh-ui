require 'test_helper'

class Forge::GoogleCodeTest < ActiveSupport::TestCase
  describe 'match' do
    it 'should return nil for garbage' do
      assert_nil Forge::GoogleCode.new.match('I am a banana!')
    end

    it 'should return nil for random URL' do
      assert_nil Forge::GoogleCode.new.match('http://lolcats.com')
    end

    it 'should accept organization url and create a new Forge::Match with the correct initialization parameters' do
      forge = Forge::GoogleCode.new
      Forge::Match.expects(:new).with(forge, 'organization', 'project_name')
      forge.match('http://code.google.com/a/organization/p/project_name/')
    end

    it 'should accept project only url and create a new Forge::Match with the correct initialization parameters' do
      forge = Forge::GoogleCode.new
      Forge::Match.expects(:new).with(forge, nil, 'project_name')
      forge.match('https://code.google.com/p/project_name/')
    end

    it 'should accept svn url and create a new Forge::Match with the correct initialization parameters' do
      forge = Forge::GoogleCode.new
      Forge::Match.expects(:new).with(forge, nil, 'project_name')
      forge.match('http://project_name.googlecode.com/svn/trunk/')
    end

    it 'should accept hg url and create a new Forge::Match with the correct initialization parameters' do
      forge = Forge::GoogleCode.new
      Forge::Match.expects(:new).with(forge, nil, 'project_name')
      forge.match('http://project_name.googlecode.com/hg/trunk/')
    end

    it 'should accept git url and create a new Forge::Match with the correct initialization parameters' do
      forge = Forge::GoogleCode.new
      Forge::Match.expects(:new).with(forge, nil, 'project_name')
      forge.match('http://project_name.googlecode.com/git/trunk/')
    end
  end

  describe 'json_api_url' do
    it 'does not have a json metadata url' do
      assert_nil Forge::GoogleCode.new.json_api_url(mock)
    end
  end
end
