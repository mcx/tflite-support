/* Copyright 2020 The TensorFlow Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/

#include "tensorflow_lite_support/java/src/native/task/vision/jni_utils.h"

#include "absl/strings/str_cat.h"

namespace tflite {
namespace support {
namespace task {
namespace vision {

constexpr char kCategoryClassName[] =
    "Lorg/tensorflow/lite/support/label/Category;";
constexpr char kStringClassName[] = "Ljava/lang/String;";
constexpr char kEmptyString[] = "";

jobject ConvertToCategory(JNIEnv* env, const Class& classification) {
  // jclass and init of Category.
  jclass category_class = env->FindClass(kCategoryClassName);
  jmethodID category_create = env->GetStaticMethodID(
      category_class, "create",
      absl::StrCat("(", kStringClassName, kStringClassName, "F)",
                   kCategoryClassName)
          .c_str());

  std::string label_string = classification.has_class_name()
                                 ? classification.class_name()
                                 : kEmptyString;
  jstring label = env->NewStringUTF(label_string.c_str());
  std::string display_name_string = classification.has_display_name()
                                        ? classification.display_name()
                                        : kEmptyString;
  jstring display_name = env->NewStringUTF(display_name_string.c_str());
  jobject jcategory =
      env->CallStaticObjectMethod(category_class, category_create, label,
                                  display_name, classification.score());
  return jcategory;
}

}  // namespace vision
}  // namespace task
}  // namespace support
}  // namespace tflite