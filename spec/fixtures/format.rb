def fixtures_data
  return @fixtures_data if @fixtures_data
  @fixtures_data = {}
  Dir.glob( File.join( File.dirname(__FILE__), 'data/**/*.qdf' ) ).each{|f|
    name = File.basename(f, '.qdf').to_s
    @fixtures_data[name] = File.read(f)
  }
  @fixtures_data
end

def qdf_format
%Q{
# first dataset
source_code: NSE
code: OIL
name: Oil India Limited
description: |-
  Here is a description with multiple lines.
  This is the second line.
-
Date, Value, High, Low
2013-11-20,9.99,11,14
2013-11-19,10.03,,14.09

# Second dataset
code:           DATASET_CODE_2
source_code:    SOURCE_CODE_2
name:           Test Dataset Name 2
description:    Here is a description with multiple lines.
-
Date, Value, High, Low
2013-11-20,9.99,11.0,14.0
2013-11-19,10.03,,14.09
2013-11-18,11.03,,15.09
}
end

def qdf_attributes
  {
    code:           'DATASET_CODE_2',
    source_code:    'NSE',
    name:           'Test Dataset Name 2',
    description:    "Here is a description with multiple lines.\n This is the second line.",
    column_names:   ['Date', 'Value', 'High', 'Low'],
    private:        false,
    reference_url:    'http://test.com/',
    data:           Quandl::Data.new([["2013-11-20", "9.99", "11.0", "14.0"],["2013-11-19", "10.03", nil, "14.09"]]),
  }
end

def qdf_attributes_to_format
%Q{source_code: NSE
code: DATASET_CODE_2
name: Test Dataset Name 2
description: |-
  Here is a description with multiple lines.
   This is the second line.
private: false
reference_url: http://test.com/
frequency: 
-
Date,Value,High,Low
2013-11-20,9.99,11.0,14.0
2013-11-19,10.03,,14.09
}
end
