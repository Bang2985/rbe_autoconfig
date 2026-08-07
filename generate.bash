#!/bin/bash
#
# Regenerates the RBE toolchain configs in this repository.
#
# Requires a sibling checkout of https://github.com/bazelbuild/bazel-toolchains
# with the rbe_configs_gen binary built (see README.md), and docker.
#
# The two values that change on a regeneration are lifted into the
# variables below:
#   BAZEL_VERSION       - keep in sync with Gerrit's .bazelversion.
#   TOOLCHAIN_CONTAINER - the Bazel-owned image, digest-pinned.
set -euo pipefail

BAZEL_VERSION="9.2.0"
TOOLCHAIN_CONTAINER="gcr.io/bazel-public/ubuntu2404@sha256:57bbaa84bec679736c53dcd1d326e8f835b3b9ce3e36c12a3c12a07eb59177d3"

../bazel-toolchains/rbe_configs_gen \
    --bazel_version="${BAZEL_VERSION}" \
    --toolchain_container="${TOOLCHAIN_CONTAINER}" \
    --output_src_root . \
    --exec_os=linux \
    --target_os=linux \
    --cpp_env_json=ubuntu2404.json
