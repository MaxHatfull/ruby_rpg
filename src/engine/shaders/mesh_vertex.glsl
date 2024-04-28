#version 330 core

// <vec2 position, vec2 texCoords, vec3 normal>
layout (location = 0) in vec3 vertex;
layout (location = 1) in vec2 texCoord;
layout (location = 2) in vec3 normal;

out vec2 TexCoord;
out vec3 Normal;
out vec3 FragPos;

uniform mat4 camera;
uniform mat4 model;

void main()
{
    TexCoord = texCoord;
    Normal = mat3(transpose(inverse(model))) * normal;
    FragPos = vec3(model * vec4(vertex, 1.0));
    gl_Position = camera * model * vec4(vertex, 1.0);
}