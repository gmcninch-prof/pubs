BINARY = pubs
INSTALLED_NAME = pubs

BUILD_DIR = .lake/build/bin
INSTALL_DIR = $(HOME)/.local/bin

OUTPUT_DIR = results 

DATA_FILE = $(HOME)/Prof-VC/cv-and-ms/publications.mlml
TEST_FILE = Test/test.mlml

.PHONY: all build install clean reports

all: build test

build:
	lake build

install: build
	cp $(BUILD_DIR)/$(BINARY) $(INSTALL_DIR)/$(INSTALLED_NAME)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

reports: $(OUTPUT_DIR) $(DATA_FILE)
	$(INSTALL_DIR)/$(BINARY) $(DATA_FILE) 

clean:
	lake clean
	rm -f $(OUTPUT_DIR)/*.md

update:
	lake update

test:
	lake exe test $(TEST_FILE)
