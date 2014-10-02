# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Header do

  let(:attributes) { header_attributes }

  subject{ Quandl::Format::Header.new(attributes) }

  describe "attributes" do
    it 'should have correct notify' do
      expect(subject.notify).to eq 'user@example.com'
    end
    it 'should have correct token' do
      expect(subject.token).to eq 'my_token'
    end

    it 'should have correct "replace"' do
      expect(subject.replace).to eq 'true'
    end
  end


end