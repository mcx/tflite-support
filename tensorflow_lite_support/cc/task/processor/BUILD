load("@org_tensorflow//tensorflow/lite/core/shims:cc_library_with_tflite.bzl", "cc_library_with_tflite")
load("//third_party/bazel_rules/rules_cc/cc:cc_library.bzl", "cc_library")

default_visibility = ["//tensorflow_lite_support:internal"]

package(
    default_visibility = default_visibility,
    licenses = ["notice"],  # Apache 2.0
)

cc_library_with_tflite(
    name = "processor",
    srcs = ["processor.cc"],
    hdrs = ["processor.h"],
    tflite_deps = [
        "@org_tensorflow//tensorflow/lite/c:common",
        "//tensorflow_lite_support/cc/task/core:tflite_engine",
    ],
    deps = [
        "//tensorflow_lite_support/cc:common",
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "@com_google_absl//absl/status",
        "@com_google_absl//absl/strings:str_format",
    ],
)

cc_library_with_tflite(
    name = "image_preprocessor",
    hdrs = ["image_preprocessor.h"],
    # Note, order of dependencies is significant here: image_preprocess_impl
    # needs to precede frame_buffer_utils.  This is needed in order to
    # ensure that the object file for frame_buffer_utils.cc ends up _after_
    # the object file for image_preprocessor.cc on the link line, despite
    # the image_preprocessor_impl only depending on frame_buffer_utils_h
    # (the target for the header file only) not on frame_buffer_utils (which
    # is the target that contains frame_buffer_utils.cc).  That order in the
    # link line is needed to avoid a "ld: error: backward reference detected"
    # error from the linker, due to the reference in image_preprocessor.cc to
    # a symbol defined in frame_buffer_utils.cc.  That's why this dependency
    # needs to be listed in 'more_deps' (which come after 'tflite_deps')
    # rather than in 'deps' (which come before 'tflite_deps').
    more_deps = [
        "//tensorflow_lite_support/cc/task/vision/utils:frame_buffer_utils",  # build_cleaner: keep
    ],
    tflite_deps = [
        ":image_preprocessor_impl",
        ":processor",
        "//tensorflow_lite_support/cc/task/vision/utils:image_tensor_specs",
    ],
    deps = [
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/task/core:task_utils",
        "//tensorflow_lite_support/cc/task/vision/core:frame_buffer",
        "//tensorflow_lite_support/cc/task/vision/proto:bounding_box_proto_inc",
    ],
)

cc_library_with_tflite(
    name = "image_preprocessor_impl",
    srcs = ["image_preprocessor.cc"],
    hdrs = ["image_preprocessor.h"],
    tflite_deps = [
        ":processor",
        "//tensorflow_lite_support/cc/task/vision/utils:image_tensor_specs",
    ],
    visibility = ["//visibility:private"],
    deps = [
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/task/core:task_utils",
        "//tensorflow_lite_support/cc/task/vision/core:frame_buffer",
        "//tensorflow_lite_support/cc/task/vision/proto:bounding_box_proto_inc",
        "//tensorflow_lite_support/cc/task/vision/utils:frame_buffer_utils_h",
        "@com_google_absl//absl/memory",
    ],
)

cc_library_with_tflite(
    name = "classification_postprocessor",
    srcs = ["classification_postprocessor.cc"],
    hdrs = ["classification_postprocessor.h"],
    tflite_deps = [
        ":processor",
        "//tensorflow_lite_support/cc/task/core:tflite_engine",
    ],
    deps = [
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/cc/task/core:classification_head",
        "//tensorflow_lite_support/cc/task/core:label_map_item",
        "//tensorflow_lite_support/cc/task/core:score_calibration",
        "//tensorflow_lite_support/cc/task/core:task_utils",
        "//tensorflow_lite_support/cc/task/processor/proto:class_cc_proto",
        "//tensorflow_lite_support/cc/task/processor/proto:classification_options_cc_proto",
        "//tensorflow_lite_support/cc/task/processor/proto:classifications_cc_proto",
        "@com_google_absl//absl/status",
        "@com_google_absl//absl/strings:str_format",
        "@org_tensorflow//tensorflow/lite/c:c_api_types",
    ],
)

cc_library_with_tflite(
    name = "embedding_postprocessor",
    srcs = ["embedding_postprocessor.cc"],
    hdrs = ["embedding_postprocessor.h"],
    tflite_deps = [
        ":processor",
        "//tensorflow_lite_support/cc/task/core:tflite_engine",
    ],
    deps = [
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/cc/task/processor/proto:embedding_options_cc_proto",
        "@com_google_absl//absl/status",
    ],
)

cc_library_with_tflite(
    name = "audio_preprocessor",
    srcs = ["audio_preprocessor.cc"],
    hdrs = ["audio_preprocessor.h"],
    tflite_deps = [
        ":processor",
        "//tensorflow_lite_support/cc/task/core:tflite_engine",
    ],
    deps = [
        "//tensorflow_lite_support/cc:common",
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/cc/task/audio/core:audio_buffer",
        "//tensorflow_lite_support/cc/task/core:task_utils",
        "@com_google_absl//absl/memory",
        "@com_google_absl//absl/status",
        "@com_google_absl//absl/strings:str_format",
    ],
)

cc_library_with_tflite(
    name = "regex_preprocessor",
    srcs = ["regex_preprocessor.cc"],
    hdrs = ["regex_preprocessor.h"],
    tflite_deps = [
        ":text_preprocessor",
    ],
    deps = [
        "//tensorflow_lite_support/cc:common",
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/cc/task/core:task_utils",
        "//tensorflow_lite_support/cc/text/tokenizers:regex_tokenizer",
        "@com_google_absl//absl/status",
    ],
)

cc_library_with_tflite(
    name = "bert_preprocessor",
    srcs = ["bert_preprocessor.cc"],
    hdrs = ["bert_preprocessor.h"],
    tflite_deps = [
        ":text_preprocessor",
    ],
    deps = [
        "//tensorflow_lite_support/cc:common",
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/cc/task/core:task_utils",
        "//tensorflow_lite_support/cc/text/tokenizers:tokenizer",
        "//tensorflow_lite_support/cc/text/tokenizers:tokenizer_utils",
        "//tensorflow_lite_support/cc/utils:common_utils",
        "@com_google_absl//absl/status",
        "@com_google_absl//absl/strings",
    ],
)

cc_library_with_tflite(
    name = "universal_sentence_encoder_preprocessor",
    srcs = ["universal_sentence_encoder_preprocessor.cc"],
    hdrs = ["universal_sentence_encoder_preprocessor.h"],
    tflite_deps = [
        ":processor",
        ":text_preprocessor",
        "//tensorflow_lite_support/cc/task/core:tflite_engine",
    ],
    deps = [
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/cc/task/core:task_utils",
        "@com_google_absl//absl/status",
    ],
)

cc_library_with_tflite(
    name = "text_preprocessor",
    hdrs = ["text_preprocessor.h"],
    tflite_deps = [
        ":processor",
        "//tensorflow_lite_support/cc/task/core:tflite_engine",
    ],
    deps = [
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/cc/task/core:task_utils",
        "@com_google_absl//absl/status",
    ],
)

cc_library_with_tflite(
    name = "search_postprocessor",
    srcs = ["search_postprocessor.cc"],
    hdrs = ["search_postprocessor.h"],
    tflite_deps = [
        ":embedding_postprocessor",
        ":processor",
        "//tensorflow_lite_support/cc/task/core:tflite_engine",
    ],
    deps = [
        ":embedding_searcher",
        "//tensorflow_lite_support/cc:common",
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/cc/task/processor/proto:embedding_cc_proto",
        "//tensorflow_lite_support/cc/task/processor/proto:embedding_options_cc_proto",
        "//tensorflow_lite_support/cc/task/processor/proto:search_options_cc_proto",
        "//tensorflow_lite_support/cc/task/processor/proto:search_result_cc_proto",
        "//tensorflow_lite_support/metadata:metadata_schema_cc",
        "//tensorflow_lite_support/metadata/cc:metadata_extractor",
        "@com_google_absl//absl/memory",
        "@com_google_absl//absl/status",
        "@com_google_absl//absl/strings",
        "@com_google_absl//absl/strings:str_format",
    ],
)

cc_library(
    name = "embedding_searcher",
    srcs = ["embedding_searcher.cc"],
    hdrs = ["embedding_searcher.h"],
    deps = [
        "//tensorflow_lite_support/cc:common",
        "//tensorflow_lite_support/cc/port:status_macros",
        "//tensorflow_lite_support/cc/port:statusor",
        "//tensorflow_lite_support/cc/task/core:external_file_handler",
        "//tensorflow_lite_support/cc/task/processor/proto:embedding_cc_proto",
        "//tensorflow_lite_support/cc/task/processor/proto:search_options_cc_proto",
        "//tensorflow_lite_support/cc/task/processor/proto:search_result_cc_proto",
        "//tensorflow_lite_support/scann_ondevice/cc:index",
        "//tensorflow_lite_support/scann_ondevice/cc/core:partitioner",
        "//tensorflow_lite_support/scann_ondevice/cc/core:processor",
        "//tensorflow_lite_support/scann_ondevice/cc/core:searcher",
        "//tensorflow_lite_support/scann_ondevice/cc/core:serialized_searcher_cc_proto",
        "//tensorflow_lite_support/scann_ondevice/cc/core:top_n_amortized_constant",
        "//tensorflow_lite_support/scann_ondevice/proto:index_config_cc_proto",
        "@com_google_absl//absl/memory",
        "@com_google_absl//absl/status",
        "@com_google_absl//absl/strings",
        "@com_google_absl//absl/strings:str_format",
        "@com_google_absl//absl/types:span",
    ],
)
