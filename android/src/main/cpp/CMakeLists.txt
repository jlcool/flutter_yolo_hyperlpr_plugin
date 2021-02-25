
cmake_minimum_required(VERSION 3.6)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fopenmp")
set(OpenCV_DIR C:\\Users\\Administrator\\Documents\\Projects\\Flutter\\flutter_yolo_hyperlpr_plugin\\android\\src\\main\\cpp\\opencv420\\sdk\\native\\jni)
if(DEFINED ANDROID_NDK_MAJOR AND ${ANDROID_NDK_MAJOR} GREATER 20)
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -static-openmp")
endif()

find_package(OpenCV REQUIRED)
message(STATUS "OpenCV libraries: ${OpenCV_LIBS}")
aux_source_directory(./lpr SOURCES1)
aux_source_directory(./src SOURCES2)
list (APPEND SOURCES
     ${SOURCES1}
     ${SOURCES2}
)
message(STATUS "My sources: ${SOURCES}")
add_library(
             hyperlpr
             SHARED
            ${SOURCES})
target_link_libraries(hyperlpr jnigraphics ${OpenCV_LIBS})





aux_source_directory(. SRC_LIST)
aux_source_directory(./ocr OCR_SRC_LIST)
add_library(
        yolov5
        SHARED
        ${SRC_LIST}
        ${OCR_SRC_LIST}
        )

include_directories(
        ncnnvulkan/include
        ocr
)

find_library(log-lib log)
find_library(android-lib android)
find_library(vulkan-lib vulkan)
find_library(jnigraphics-lib jnigraphics)
add_library( ncnn STATIC IMPORTED )
set_target_properties( # Specifies the target library.
        ncnn
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/ncnnvulkan/${ANDROID_ABI}/libncnn.a )


# ncnnvulkan
add_library(glslang STATIC IMPORTED)
add_library(OGLCompiler STATIC IMPORTED)
add_library(OSDependent STATIC IMPORTED)
add_library(SPIRV STATIC IMPORTED)
set_target_properties(glslang PROPERTIES IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/ncnnvulkan/${ANDROID_ABI}/libglslang.a)
set_target_properties(OGLCompiler PROPERTIES IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/ncnnvulkan/${ANDROID_ABI}/libOGLCompiler.a)
set_target_properties(OSDependent PROPERTIES IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/ncnnvulkan/${ANDROID_ABI}/libOSDependent.a)
set_target_properties(SPIRV PROPERTIES IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/ncnnvulkan/${ANDROID_ABI}/libSPIRV.a)


include_directories(
        ${CMAKE_SOURCE_DIR}/opencv420/sdk/native/jni/include/
)
add_library(libopencv_java4 STATIC IMPORTED)
set_target_properties(
        libopencv_java4
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/opencv420/sdk/native/libs/${ANDROID_ABI}/libopencv_java4.so
        )
target_link_libraries( # Specifies the target library.
        yolov5
        ${log-lib}
        ${vulkan-lib}
        ${android-lib}
        ${jnigraphics-lib}
        libopencv_java4)


target_link_libraries( # Specifies the target library.
        yolov5
        ${log-lib}
        ${vulkan-lib}
        ${android-lib}
        ${jnigraphics-lib}
        ncnn
        glslang SPIRV OGLCompiler OSDependent )