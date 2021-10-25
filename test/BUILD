load("@py_deps//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary")

py_binary(
    name = "test",
    srcs = [
        "test.py",
    ],
    main = "test.py",
    deps = [
        requirement("numpy")
    ],
)
