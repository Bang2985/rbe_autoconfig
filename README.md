#### RBE toolchain config for a given combination of Bazel release and docker image

Clone the [bazel-toolchains](https://github.com/bazelbuild/bazel-toolchains.git)
project.

Build the `rbe_configs_gen` with the following command:

```
  $ docker run \
      --rm -v $PWD:/srcdir -w /srcdir golang:1.16 \
      go build -o rbe_configs_gen \
      ./cmd/rbe_configs_gen/rbe_configs_gen.go
```

Clone this repository to `/home/<user>/projects/rbe_autoconfig`
directory and run this command in `bazel-toolchain` directory:

```
  $ <path/to/bazel/toolchains>/rbe_configs_gen \
    --bazel_version=9.2.0 \
    --toolchain_container=gcr.io/bazel-public/ubuntu2404@sha256:57bbaa84bec679736c53dcd1d326e8f835b3b9ce3e36c12a3c12a07eb59177d3 \
    --output_src_root . \
    --exec_os=linux \
    --target_os=linux \
    --cpp_env_json=ubuntu2404.json
```

Used ubuntu2404.json file:

```
{
  "ABI_LIBC_VERSION": "glibc_2.39",
  "ABI_VERSION": "gcc",
  "BAZEL_COMPILER": "gcc",
  "BAZEL_HOST_SYSTEM": "x86_64-unknown-linux-gnu",
  "BAZEL_TARGET_CPU": "k8",
  "BAZEL_TARGET_LIBC": "glibc_2.39",
  "BAZEL_TARGET_SYSTEM": "x86_64-unknown-linux-gnu",
  "CC": "gcc",
  "CC_TOOLCHAIN_NAME": "linux_gnu_x86"
}
```

Commit and push the regenerated config. Consume it from the Gerrit
project by pinning the commit in `MODULE.bazel` (Bazel 9.x removed
`WORKSPACE`, so Bzlmod is the only supported path):

```python
bazel_dep(name = "rbe_autoconfig")
git_override(
    module_name = "rbe_autoconfig",
    remote = "https://github.com/davido/rbe_autoconfig.git",
    commit = "f19673d99a078b9f739e5738f75b254364fe777b",
)
```
