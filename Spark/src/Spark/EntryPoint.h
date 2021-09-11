#pragma once


#ifdef SP_PLATFORM_WINDOWS

extern Spark::Application* Spark::CreateApplication();

int main(int argc, char** argv)
{
	Spark::Log::Init();

	SPARK_CORE_WARN("Initialized log");
	SPARK_INFO("Initialized log");

	auto app = Spark::CreateApplication();
	app->Run();
	delete app;
}

#endif