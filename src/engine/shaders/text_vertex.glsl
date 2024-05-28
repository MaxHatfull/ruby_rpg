#version 330 core

// <vec2 position>
layout (location = 0) in vec3 vertex;

uniform mat4 camera;
uniform mat4 model;

void main()
{
    gl_Position = camera * model * vec4(vertex, 1.0);
}