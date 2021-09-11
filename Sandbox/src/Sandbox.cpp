#include "sppch.h"
#include "Spark.h"


class ExampleLayer : public Spark::Layer
{
public:
	ExampleLayer()
		: Layer("Example")
	{
	}

	void OnUpdate() override
	{
		
	}

	void OnEvent(Spark::Event& event) override
	{
		SPARK_TRACE("{0}", event);
	}
};

class Sandbox : public Spark::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
		PushOverlay(new Spark::ImGuiLayer());
	}

	~Sandbox()
	{

	}
};

Spark::Application* Spark::CreateApplication()
{
	return new Sandbox();
}