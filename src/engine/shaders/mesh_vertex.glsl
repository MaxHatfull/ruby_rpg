#version 330 core

// <vec2 position, vec2 texCoords, vec3 normal>
layout (location = 0) in vec3 vertex;
layout (location = 1) in vec2 texCoord;
layout (location = 2) in vec3 normal;


uniform mat4 camera;
uniform mat4 model;

void main()
{
    gl_Position = camera * model * vec4(vertex, 1.0);
}