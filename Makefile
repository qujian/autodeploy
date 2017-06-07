PROJECT = autodeploy
DEPS = cowboy lager

dep_cowboy = git https://github.com/ninenines/cowboy master
dep_lager = git https://github.com/basho/lager master

ifeq ($(shell findmnt -no FSTYPE /tmp), tmpfs)
RELX_OUTPUT_DIR ?= /tmp/autodeploy
endif

# TODO: compare with URL in erlang.mk
RELX_URL := https://github.com/erlware/relx/releases/download/v1.1.0/relx

include erlang.mk

ERLC_OPTS += +'{parse_transform, lager_transform}'
TEST_ERLC_OPTS += +'{parse_transform, lager_transform}'

PLT_APPS = inets ssl xmerl
DIALYZER_DIRS = ebin

.PHONY: debug release

debug: ERLC_OPTS += -DDEBUG=1
debug: all

release: RELX_OUTPUT_DIR := _rel
release: clean all

