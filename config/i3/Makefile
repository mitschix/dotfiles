ifndef VERBOSE
.SILENT:
endif

all: create_default

.PHONY: clean_bk

create_default:
	@mv config config_$(shell date -u +"%Y%m%d_%H") 2>/dev/null
	@cat src/*_* > config
	@cat src/adds/*_* >> config
	@cat src/plugs/* >> config

create_custom:
	@mv config config_$(shell date -u +"%Y%m%d_%H")
	@cat src/*_* > config
	@cat src/custom/*_* >> config

clean_bk:
	@rm -f config_20*
