# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Header::Attributes do

  let(:attributes) { header_attributes }

  subject{ Quandl::Format::Header.new( attributes ) }

end