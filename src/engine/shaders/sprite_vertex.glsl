#version 330 core
layout (location = 0) in vec3 vertex; // <vec2 position, vec2 texCoords>
layout (location = 1) in vec2 texCoord; // <vec2 position, vec2 texCoords>

out vec2 TexCoords;

uniform mat4 camera;
uniform mat4 model;

void main()
{
    TexCoords = texCoord;
    gl_Position = camera * model * vec4(vertex, 1.0);
}