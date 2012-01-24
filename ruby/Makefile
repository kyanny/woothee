all: test

TIMESTAMP=$(shell date +%Y%m%d-%H%M%S)

checkyaml:
	perl ../bin/dataset_checker.pl

lib/woothee/dataset.rb: ../dataset.yaml
	perl ../bin/dataset_yaml2rb.pl
	sync; sync; sync;

test: lib/woothee/dataset.rb
	ruby -Ilib test/test_runner.rb
