load("@build_bazel_rules_android//android:rules.bzl", "android_library")
load("@org_tensorflow//tensorflow/lite/core/shims:cc_library_with_tflite.bzl", "android_library_with_tflite")
load("@org_tensorflow//tensorflow/lite/java:aar_with_jni.bzl", "aar_with_jni")

package(
    default_visibility = ["//visibility:public"],
    licenses = ["notice"],  # Apache 2.0
)

filegroup(
    name = "bert_question_answerer_src",
    srcs = glob(["**/*.java"]),
)

# Default target that uses BuiltInOpResolver, registers all built-in OPs.
android_library_with_tflite(
    name = "bert_question_answerer",
    tflite_exports = [
        "//tensorflow_lite_support/java/src/native/task/text/qa:bert_question_answerer_native",
    ],
    exports = [
        ":bert_question_answerer_java",
    ],
)

# Java-only target, need to be used together with a native target similar to
# //third_party/tensorflow_lite_support/java/src/native/task/text/qa:bert_question_answerer_native.
# Use this target when you want to provide a MutableOpResolver with customized
# OPs and/or a subset of BuiltInOps to reduce binary size.
android_library(
    name = "bert_question_answerer_java",
    srcs = glob(["*.java"]),
    deps = [
        "//tensorflow_lite_support/java/src/java/org/tensorflow/lite/task/core:base_task_api",
        "@com_google_auto_value",
        "@org_tensorflow//tensorflow/lite/java:tensorflowlite_java_stable",
    ],
)

# AAR target for OSS release.
#
# bazel build -c opt --config=monolithic --config=android_arm64 --fat_apk_cpu=x86,x86_64,arm64-v8a,armeabi-v7a \
#   tensorflow_lite_support/java/src/java/org/tensorflow/lite/task/text/qa:bert-question-answerer
aar_with_jni(
    name = "bert-question-answerer",
    android_library = ":bert_question_answerer",
)
