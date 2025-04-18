# Copyright 2023 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

from _typeshed import Incomplete

class AndroidJavaGenerator:
    def __init__(self, arg0: str) -> None: ...
    def generate(self, *args, **kwargs): ...
    def get_error_message(self) -> str: ...

class GenerationResult:
    files: Incomplete
    def __init__(self) -> None: ...

class GenerationResultFile:
    content: str
    path: str
    def __init__(self) -> None: ...
