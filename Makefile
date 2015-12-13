SWIFTC=swiftc
UNAME=$(shell uname)

ifeq ($(UNAME), Darwin)
XCODE=$(shell xcode-select -p)
SDK=$(XCODE)/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk
TARGET=x86_64-apple-macosx10.10
SWIFTC=swiftc -target $(TARGET) -sdk $(SDK) -Xlinker -all_load
endif

BUILD_DIR=.build/debug
#BUILD_OPTS=-v
TEST_DIR=Tests/Packages/$(BUILD_DIR)

LIBS=$(wildcard $(BUILD_DIR)/*.a)
LIBS+=$(wildcard $(TEST_DIR)/*.a)
LDFLAGS=$(foreach lib,$(LIBS),-Xlinker $(lib))

.PHONY: all clean lib tests

all: lib
	./$(BUILD_DIR)/yolo do

clean:
	swift build --clean
	cd Tests/Packages && swift build --clean

lib:
	swift build

test: lib $(BUILD_DIR)/test_runner
	./$(BUILD_DIR)/test_runner

$(BUILD_DIR)/test_runner: Tests/*.swift
	cd Tests/Packages && swift build $(BUILD_OPTS)
	$(SWIFTC) -o $@ $< -I$(BUILD_DIR) -I$(TEST_DIR) $(LDFLAGS)
