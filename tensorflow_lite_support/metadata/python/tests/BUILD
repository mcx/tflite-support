# Placeholder: load py_test

package(
    default_visibility = [
        "//visibility:public",
    ],
    licenses = ["notice"],  # Apache 2.0
)

py_test(
    name = "metadata_test",
    srcs = ["metadata_test.py"],
    data = ["//tensorflow_lite_support/metadata/python/tests/testdata:test_files"],
    deps = [
        # build rule placeholder: google/protobuf:use_fast_cpp_protos dep,  # Automatically added go/proto_python_upb_flip
        # build rule placeholder: six dep,
        # build rule placeholder: tensorflow dep,
        "//tensorflow_lite_support/metadata:metadata_schema_py",
        "//tensorflow_lite_support/metadata:schema_py",
        "//tensorflow_lite_support/metadata/python:metadata",
        "@flatbuffers//:runtime_py",
    ],
)

py_test(
    name = "metadata_parser_test",
    srcs = ["metadata_parser_test.py"],
    deps = [
        # build rule placeholder: google/protobuf:use_fast_cpp_protos dep,  # Automatically added go/proto_python_upb_flip
        # build rule placeholder: tensorflow dep,
        "//tensorflow_lite_support/metadata/python:metadata",
    ],
)

py_test(
    name = "metadata_writer_for_task_test",
    srcs = ["metadata_writer_for_task_test.py"],
    data = [
        "//tensorflow_lite_support/metadata/python/tests/testdata/audio_classifier:test_files",
        "//tensorflow_lite_support/metadata/python/tests/testdata/audio_embedder:test_files",
        "//tensorflow_lite_support/metadata/python/tests/testdata/image_classifier:test_files",
    ],
    deps = [
        # build rule placeholder: google/protobuf:use_fast_cpp_protos dep,  # Automatically added go/proto_python_upb_flip
        # build rule placeholder: tensorflow dep,
        "//tensorflow_lite_support/metadata/python:metadata_writer_for_task",
        "//tensorflow_lite_support/metadata/python/tests/metadata_writers:test_utils",
    ],
)
