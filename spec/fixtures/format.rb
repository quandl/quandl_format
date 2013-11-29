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
2013-11-20,9.99470588235294,11.003235294117646,14.00164705882353
2013-11-19,10.039388096885814,,14.09718770934256

# Second dataset
code:           DATASET_CODE_2
source_code:    SOURCE_CODE_2
name:           Test Dataset Name 2
description:    Here is a description with multiple lines.
-
Date, Value, High, Low
2013-11-20,9.99470588235294,11.003235294117646,14.00164705882353
2013-11-19,10.039388096885814,,14.09718770934256
2013-11-18,11.039388096885814,,15.09718770934256
}
end

def qdf_attributes
  {
    code:           'DATASET_CODE_2',
    source_code:    'SOURCE_CODE',
    name:           'Test Dataset Name 2',
    description:    "Here is a description with multiple lines.\n This is the second line.",
    column_names:   ['Date', 'Value', 'High', 'Low'],
    private:        false,
    display_url:    'http://test.com/',
    data:           [["2013-11-20", "9.99470588235294", "11.003235294117646", "14.00164705882353"],["2013-11-19", "10.039388096885814", nil, "14.09718770934256"]],
  }
end

def qdf_attributes_to_format
%Q{source_code: SOURCE_CODE
code: DATASET_CODE_2
name: Test Dataset Name 2
description: |-
  Here is a description with multiple lines.
   This is the second line.
private: false
display_url: http://test.com/
-
Date,Value,High,Low
2013-11-20,9.99470588235294,11.003235294117646,14.00164705882353
2013-11-19,10.039388096885814,,14.09718770934256
}
end
