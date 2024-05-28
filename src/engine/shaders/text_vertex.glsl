#version 330 core

// <vec3 position, vec2 texCoords>
layout (location = 0) in vec3 vertex;
layout (location = 1) in vec2 texCoords;

uniform mat4 camera;
uniform mat4 model;
out vec2 TexCoords;

void main()
{
    gl_Position = camera * model * vec4(vertex, 1.0);
    TexCoords = texCoords.xy;
}