## 0.2.8

* QUGC-57 validation at an inappropriate time; move validations to Quandl::Client
* more accurate error messages and line numbers


## 0.2.7

* parsing junk string should fail gracefully


## 0.2.6

* require yaml
* dont assign data if data is not present


## 0.2.5

* QUGC-40 respond with error status if errors are blank
* QUGC-37 field names should be case insensitive


## 0.2.4

* assigning data will force to_table if possible
* QUGC-38 Dataset#column_names should be read before data
* permit setting frequency in quandl format

## 0.2.3

* QUGC-35 Pure Meta Data Send or Update
* remove babelfish from gemspec


## 0.2.0

* Update Quandl::Client to gain access to Quandl::Pattern
* Errors dont output internal attributes in error messages
* Display more information around YAML Parse Failures


## 0.1.8

* add Quandl::Format::Dataset.each_line to upload dataset's line by line as they become availabe from whichever interface. Allows ruby GC to operate and avoid having 20k datasets in memory ...


## 0.1.7

* Accept tabular data


## 0.1.6

* refactor errors to include specific line numbers
* revise errors to be more human friendly


## 0.1.5

* Replace Quandl::Babelfish::Data with Quandl::Data, now that QD does intelligent cleaning.


## 0.1.4

* Add quandl_babelfish as a runtime_dependency
* add spec for annual data using Babelfish.clean
* refactor errors to be general to Quandl::Error
* switch incoming data to use babelfish. column_names come from babelfish.headers


## 0.1.2

* mismatched columns should raise ColumnCountMismatch
* revise specs to take reference_url instead of display_url
* revise attribute display_url to reference_url


## 0.1.0

* only update client attrs before upload
* dataset/client.rb client.assign_attributes(attributes) before upload human_errors revised
* load rescues and raises contextual errors
* add Dataset#human_errors, #full_url
* add fixtures/data/*.qdf that gets loaded into fixtures_data
* refactor spec format and qdf_attributes to fixtures
* add quandl/client/dataset/to_qdf extension Dataset#to_qdf Dataset#qdf_attributes
* refactor node/dump/load to Dataset Dataset::Load, Dataset::Dump


## 0.0.2

* add support for meta attributes: private, display_url


## 0.0.1

* init