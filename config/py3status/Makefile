ifndef VERBOSE
.SILENT:
endif

all: create_config

.PHONY: clean_bk

create_config:
	@mv config config_$(shell date -u +"%Y%m%d_%H") 2>/dev/null || :
	@cat conf.d/* > config
	# remove all vim settings from config file
	@sed -i '/#\ vim:/d' config

clean_bk:
	@rm -f config_20*
