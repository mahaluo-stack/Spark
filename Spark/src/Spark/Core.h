#pragma once
#include "sppch.h"

#ifdef SP_PLATFORM_WINDOWS
	#ifdef SP_BUILD_DLL	
		#define SPARK_API __declspec(dllexport)
	#else
		#define SPARK_API __declspec(dllimport)
	#endif
#else
	#error Spark only supports Windows!
#endif

#ifdef Spark_ENABLE_ASSERTS
	#define SPARK_ASSERT(x, ...) { if(!(x)) { SPARK_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak; } }
	#define SPARK_CORE_ASSERT(x, ...) { if(!(x)) { SPARK_CORE_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak; } }
#else
	#define SPARK_ASSERT(x, ...)
	#define SPARK_CORE_ASSERT(x, ...)
#endif 


#define BIT(x) (1 << x)

#define SP_BIND_EVENT_FN(fn) std::bind(&fn, this, std::placeholders::_1)