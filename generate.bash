#!/bin/bash
../bazel-toolchains/rbe_configs_gen \
    --bazel_version=9.2.0 \
    --toolchain_container=gcr.io/bazel-public/ubuntu2404@sha256:57bbaa84bec679736c53dcd1d326e8f835b3b9ce3e36c12a3c12a07eb59177d3 \
    --output_src_root . \
    --exec_os=linux \
    --target_os=linux \
    --cpp_env_json=ubuntu2404.json
