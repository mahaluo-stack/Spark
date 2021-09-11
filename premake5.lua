workspace "Spark"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "Spark/vendor/GLFW/include"
IncludeDir["Glad"] = "Spark/vendor/Glad/include"
IncludeDir["ImGui"] = "Spark/vendor/imgui"

include "Spark/vendor/GLFW"
include "Spark/vendor/Glad"
include "Spark/vendor/imgui"

project "Spark"
	location "Spark"
	kind "SharedLib"
	language "C++"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "sppch.h"
	pchsource "Spark/src/sppch.cpp"

	files 
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		--"%{prj.name}/vendor/stb_image/**.h",
		--"%{prj.name}/vendor/stb_image/**.cpp",
		--"%{prj.name}/vendor/glm/glm/**.hpp",
		--"%{prj.name}/vendor/glm/glm/**.inl"
	}	

	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"GLFW_INCLUDE_NONE"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}"
		--"%{IncludeDir.glm}",
		--"%{IncludeDir.stb_image}",
		--"%{IncludeDir.entt}"
	}

	links
	{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"SP_PLATFORM_WINDOWS",
			"SP_BUILD_DLL",
			"_WINDLL"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}


	filter "configurations:Debug"
		defines "SP_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines "SP_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Dist"
		defines "SP_DIST"
		buildoptions "/MD"
		optimize "On"

	filter { "system:windows", "configurations:Release" }
		buildoptions "/MT"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"


	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files 
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Spark/vendor/spdlog/include",
		"Spark/vendor",
		"Spark/src"
	}

	links
	{
		"Spark"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"SP_PLATFORM_WINDOWS",
		}

	filter "configurations:Debug"
		defines "SP_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines "SP_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Dist"
		defines "SP_DIST"
		buildoptions "/MD"
		optimize "On"




