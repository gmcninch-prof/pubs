BINARY          = pubs

BUILD_DIR       = .lake/build/bin
INSTALL_DIR     = $(HOME)/.local/bin

REPO_OUTPUT_DIR = results 
CV_OUTPUT_DIR   = /home/george/Prof-VC/cv-and-ms
WEB_OUTPUT_DIR  = /home/george/Web-hakyll/prof/pages

DATA_FILE       = $(HOME)/Prof-VC/cv-and-ms/publications.mlml

TEST_DATA_FILE       = Test/test.mlml
TEST_OUTPUT          = Test

.PHONY: all build install clean reports update test

all: build test

build:
	lake build

install: build
	cp $(BUILD_DIR)/$(BINARY) $(INSTALL_DIR)/$(BINARY)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

reports: $(OUTPUT_DIR) $(DATA_FILE)

# output to `results` directory
	$(INSTALL_DIR)/$(BINARY) $(DATA_FILE) $(REPO_OUTPUT_DIR) $(REPO_OUTPUT_DIR)

# output to `CV_OUTPUT_DIR` and `WEB_OUTPUT_DIR`
	$(INSTALL_DIR)/$(BINARY) $(DATA_FILE) $(CV_OUTPUT_DIR) $(WEB_OUTPUT_DIR)

clean:
	lake clean
	rm -f $(OUTPUT_DIR)/*.md

update:
	lake update

test:
	$(INSTALL_DIR)/$(BINARY) $(TEST_DATA_FILE) $(TEST_OUTPUT) $(TEST_OUTPUT)

