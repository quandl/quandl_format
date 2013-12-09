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