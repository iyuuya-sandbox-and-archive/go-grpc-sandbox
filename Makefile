export GO111MODULE=on

# ==============================================================================
# Generate
# ==============================================================================
.PHONY: gen
gen: depends build/proto

.PHONY: build/proto
build/proto: pkg/grpc
	@cd api && \
		protoc --go_out=../pkg/grpc --go_opt=paths=source_relative \
			--go-grpc_out=../pkg/grpc --go-grpc_opt=paths=source_relative \
			hello.proto
pkg/grpc:
	@mkdir -p pkg/gprc

# ==============================================================================
# Run
# ==============================================================================
.PHONY: run/server
run/server:
	go run github.com/iyuuya-sandbox-and-archive/go-grpc-sandbox/cmd/server

.PHONY: run/client
run/client:
	go run github.com/iyuuya-sandbox-and-archive/go-grpc-sandbox/cmd/client

# ==============================================================================
# Depends
# ==============================================================================
.PHONY: depends
depends: depends/protoc depends/protoc-gen-go depends/protoc-gen-go-grpc

.PHONY: depends/protoc
depends/protobuf:
	@command -V protoc > /dev/null 2>&1 || \
		brew install protobuf

.PHONY: depends/protoc-gen-go
depends/protoc-gen-go:
	@command -V protoc-gen-go > /dev/null 2>&1 || \
		go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28

.PHONY: depends/protoc-gen-go-grpc
depends/protoc-gen-go-grpc:
	@command -V protoc-gen-go-grpc > /dev/null 2>&1 || \
		go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
