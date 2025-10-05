#!/bin/bash

services=("auth" "user" "chat")

for service in "${services[@]}"; do
  echo "Generating code for $service.proto..."
  protoc \
    --go_out=./$service --go_opt=paths=source_relative \
    --go-grpc_out=./$service --go-grpc_opt=paths=source_relative \
    --proto_path=. \
    --validate_out="lang=go,paths=source_relative:./$service" \
    "$service.proto"

  if [ $? -ne 0 ]; then
    echo "Failed to generate for $service.proto"
    exit 1
  fi
done

echo "Generation completed!! ＼(＾▽＾)／"