"""Build definitions supporting platform-independent native build."""

load("@bazel_skylib//lib:selects.bzl", "selects")
load("@org_tensorflow//tensorflow:tensorflow.bzl", "tf_copts", "tf_opts_nortti_if_android")

def micore_if(android, ios = [], default = []):
    """Helper to create a select.

    Args:
      android: what to return if compiling for Android.
      ios: what to return if compiling for iOS.
      default: what to return otherwise.
    Returns:
      the `android` list for Android compilation and the
      `default` list otherwise.
    """
    return select({
        ":android": android,
        ":apple": ios,
        "//conditions:default": default,
    })

def micore_tf_copts():
    """C options for Tensorflow builds.

    Returns:
      a list of copts which must be used by each cc_library which
      refers to Tensorflow. Enables the library to compile both for
      Android and for Linux.
    """
    return tf_copts(android_optimization_level_override = None) + tf_opts_nortti_if_android() + [
        "-Wno-narrowing",
        "-Wno-sign-compare",
        "-Wno-overloaded-virtual",
    ] + micore_if(
        android = [
            # Set a define so Tensorflow's register_types.h
            # adopts to support a rich set of types, to be pruned by
            # selective registration.
            "-DSUPPORT_SELECTIVE_REGISTRATION",
            # Selective registration uses constexprs with recursive
            # string comparisons; that can lead to compiler errors, so
            # we increase the constexpr recursion depth.
            "-fconstexpr-depth=1024",
        ],
    ) + selects.with_or({
        # If building for armeabi-v7a, and if compilation_mode is 'fastbuild'
        # or 'dbg' then forcefully add -Oz to the list compiler options.
        # Without it, some TF dependencies can't build (b/112286436). If
        # compilation_mode is 'opt' then rely on the toolchain default.
        (
            ":armeabi_v7a_and_fastbuild",
            ":armeabi_v7a_and_dbg",
        ): ["-Oz"],
        "//conditions:default": [],
    })

def micore_tf_deps():
    """Dependencies for Tensorflow builds.

    Returns:
      list of dependencies which must be used by each cc_library
      which refers to Tensorflow. Enables the library to compile both for
      Android and for Linux. Use this macro instead of directly
      declaring dependencies on Tensorflow.
    """
    return micore_if(
        android = [
            # Link to library which does not contain any ops.
            "@org_tensorflow//tensorflow/core:portable_tensorflow_lib_lite",
            "@gemmlowp//:eight_bit_int_gemm",
            "@fft2d//:fft2d",
        ],
        ios = [
            "@org_tensorflow//tensorflow/core:portable_tensorflow_lib",
            "@gemmlowp//:eight_bit_int_gemm",
            "@fft2d//:fft2d",
        ],
        default = [
            # Standard references for Tensorflow when building for Linux. We use
            # an indirection via the alias targets below, to facilitate whitelisting
            # these deps in the mobile license presubmit checks.
            "@local_config_tf//:libtensorflow_framework",
            "@local_config_tf//:tf_header_lib",
        ],
    )
