load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@org_tensorflow//tensorflow/lite:special_rules.bzl", "tflite_ios_lab_runner")
load("@org_tensorflow//tensorflow/lite/ios:ios.bzl", "TFL_DEFAULT_TAGS", "TFL_DISABLED_SANITIZER_TAGS", "TFL_MINIMUM_OS_VERSION")
load("//third_party/bazel_rules/rules_cc/cc:objc_library.bzl", "objc_library")

package(
    default_visibility = ["//visibility:private"],
    licenses = ["notice"],  # Apache 2.0
)

objc_library(
    name = "TFLImageSegmenterObjcTestLibrary",
    testonly = 1,
    srcs = ["TFLImageSegmenterTests.m"],
    data = [
        "//tensorflow_lite_support/cc/test/testdata/task/vision:test_images",
        "//tensorflow_lite_support/cc/test/testdata/task/vision:test_models",
    ],
    tags = TFL_DEFAULT_TAGS,
    deps = [
        "//tensorflow_lite_support/ios/task/vision:TFLImageSegmenter",
        "//tensorflow_lite_support/ios/task/vision/utils:GMLImageUtils",
    ],
)

ios_unit_test(
    name = "TFLImageSegmenterObjcTest",
    minimum_os_version = TFL_MINIMUM_OS_VERSION,
    runner = tflite_ios_lab_runner("IOS_LATEST"),
    tags = TFL_DEFAULT_TAGS + TFL_DISABLED_SANITIZER_TAGS,
    deps = [
        ":TFLImageSegmenterObjcTestLibrary",
    ],
)

swift_library(
    name = "TFLImageSegmenterSwiftTestLibrary",
    testonly = 1,
    srcs = ["TFLImageSegmenterTests.swift"],
    data = [
        "//tensorflow_lite_support/cc/test/testdata/task/vision:test_images",
        "//tensorflow_lite_support/cc/test/testdata/task/vision:test_models",
    ],
    tags = TFL_DEFAULT_TAGS,
    deps = [
        "//tensorflow_lite_support/ios/task/vision:TFLImageSegmenter",
        "//tensorflow_lite_support/ios/task/vision/utils:GMLImageUtils",
    ],
)

ios_unit_test(
    name = "TFLImageSegmenterSwiftTest",
    minimum_os_version = TFL_MINIMUM_OS_VERSION,
    runner = tflite_ios_lab_runner("IOS_LATEST"),
    tags = TFL_DEFAULT_TAGS + TFL_DISABLED_SANITIZER_TAGS,
    deps = [
        ":TFLImageSegmenterSwiftTestLibrary",
    ],
)
