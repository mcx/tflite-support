load("//tensorflow_lite_support/metadata:build_defs.bzl", "stamp_metadata_parser_version")
load("//third_party/bazel_rules/rules_cc/cc:cc_library.bzl", "cc_library")

package(
    default_visibility = ["//tensorflow_lite_support:internal"],
    licenses = ["notice"],  # Apache 2.0
)

stamp_metadata_parser_version(
    name = "metadata_parser_h",
    srcs = ["metadata_parser.h.template"],
    outs = ["metadata_parser.h"],
)

cc_library(
    name = "metadata_extractor",
    srcs = ["metadata_extractor.cc"],
    hdrs = ["metadata_extractor.h"],
    visibility = ["//visibility:public"],
    deps = [
        "//tensorflow_lite_support/cc:common",
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/metadata:metadata_schema_cc",
        "//tensorflow_lite_support/metadata/cc/utils:zip_readonly_mem_file",
        "@com_google_absl//absl/container:flat_hash_map",
        "@com_google_absl//absl/memory",
        "@com_google_absl//absl/status",
        "@com_google_absl//absl/strings",
        "@com_google_absl//absl/strings:str_format",
        "@flatbuffers",
        "@org_tensorflow//tensorflow/lite/schema:schema_fbs",
        "@zlib//:zlib_minizip",
    ],
)

cc_library(
    name = "metadata_version",
    srcs = ["metadata_version.cc"],
    hdrs = [
        "metadata_version.h",
        ":metadata_parser_h",
    ],
    deps = [
        "//tensorflow_lite_support/metadata:metadata_schema_cc",
        "@com_google_absl//absl/strings",
        "@flatbuffers",
        "@org_tensorflow//tensorflow/lite/c:common",
        "@org_tensorflow//tensorflow/lite/kernels/internal:compatibility",
        "@org_tensorflow//tensorflow/lite/tools:logging",
    ],
)

cc_library(
    name = "metadata_populator",
    srcs = ["metadata_populator.cc"],
    hdrs = ["metadata_populator.h"],
    visibility = ["//visibility:public"],
    deps = [
        "//tensorflow_lite_support/cc:common",
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/metadata:metadata_schema_cc",
        "//tensorflow_lite_support/metadata/cc/utils:zip_writable_mem_file",
        "@com_google_absl//absl/container:flat_hash_map",
        "@com_google_absl//absl/status",
        "@flatbuffers//:runtime_cc",
        "@org_tensorflow//tensorflow/lite/schema:schema_fbs",
        "@zlib//:zlib_minizip",
    ],
)
