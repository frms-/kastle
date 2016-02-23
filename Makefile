PROJECT = kastle
PROJECT_DESCRIPTION = Apache Kafka REST interface
PROJECT_VERSION = 0.0.1

# Whitespace to be used when creating files from templates.
SP = 2
DEPS = brod cowboy lager
dep_brod = git https://github.com/klarna/brod.git add-api-to-start-producer-on-demand

include erlang.mk

# Compile flags
ERLC_COMPILE_OPTS = +'{parse_transform, lager_transform}'

# Append these settings
ERLC_OPTS += $(ERLC_COMPILE_OPTS)
TEST_ERLC_OPTS += $(ERLC_COMPILE_OPTS)

