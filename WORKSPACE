workspace(name = "brand_monitoring")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Fetch Python and build it from scratch
http_archive(
    name = "python_interpreter",
    build_file_content = """
exports_files(["python_bin"])
filegroup(
    name = "files",
    srcs = glob(["bazel_install/**"], exclude = ["**/* *"]),
    visibility = ["//visibility:public"],
)
""",
    patch_cmds = [
        "mkdir $(pwd)/bazel_install",
        "./configure --prefix=$(pwd)/bazel_install",
        "make",
        "make install",
        "ln -s bazel_install/bin/python3 python_bin",
    ],
    sha256 = "9c73e63c99855709b9be0b3cc9e5b072cb60f37311e8c4e50f15576a0bf82854",
    strip_prefix = "Python-3.9.0",
    urls = ["https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tar.xz"],
)

# Fetch official Python rules for Bazel
http_archive(
    name = "rules_python",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.4.0/rules_python-0.4.0.tar.gz",
    sha256 = "954aa89b491be4a083304a2cb838019c8b8c3720a7abb9c4cb81ac7a24230cea",
)

# Third party libraries
load("@rules_python//python:pip.bzl", "pip_install")

pip_install(
    name = "py_deps",
    python_interpreter_target = "@python_interpreter//:python_bin",
    requirements = "//:requirements.txt",
)

# The Python toolchain must be registered ALWAYS at the end of the file
register_toolchains("//:py_3_toolchain")
