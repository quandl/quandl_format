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