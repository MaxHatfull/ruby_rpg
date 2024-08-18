#version 330 core

layout (location = 0) in vec3 vertex;

out vec3 FragPos;

uniform mat4 camera;
uniform mat4 model;

void main()
{
    mat3 normalMatrix = mat3(transpose(inverse(model)));
    FragPos = vec3(model * vec4(vertex, 1.0));
    gl_Position = camera * model * vec4(vertex, 1.0);
}
