# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset::Load do

  describe ".string" do
    describe "valid header" do

      let(:format) { header_format }
      let(:header) { Quandl::Format::Header::Load.string(format) }
      subject { header }

      describe "attributes loaded" do
        it { should be_a Quandl::Format::Header }

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

    describe "invalid header" do

      let(:format) { invalid_header_format }

      it 'should raise error' do
        expect { Quandl::Format::Header::Load.string(format) }.to raise_error(Quandl::Error::InvalidHeader)
      end

    end

    describe "invalid attribute" do

      let(:format) { invalid_attr_header_format }

      subject { header }

      it 'should raise error' do
        expect { Quandl::Format::Header::Load.string(format) }.to raise_error(Quandl::Error::UnknownAttribute)
      end

    end

    describe "no header" do

      let(:format) { qdf_format }

      subject { header }

      it 'should not raise error' do
        expect(Quandl::Format::Header::Load.string(format)).to be nil
      end

    end


  end
end