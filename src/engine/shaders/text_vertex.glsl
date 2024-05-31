#version 330 core

// <vec3 position, vec2 texCoords>
layout (location = 0) in vec3 vertex;
layout (location = 1) in vec2 texCoords;

uniform mat4 camera;
uniform mat4 model;
uniform int text[100];
uniform float offsets[100];

out vec2 TexCoords;

vec2 getTexCoords(int index)
{
    int x = index / 16;
    int y = index % 16;
    return (vec2(x, y) + texCoords) / 16.0;
}

vec3 quadPosition()
{
    return vertex + vec3(offsets[gl_InstanceID], 0, 0)/2;
}


void main()
{
    gl_Position = camera * model * vec4(quadPosition(), 1.0);
    TexCoords = getTexCoords(text[gl_InstanceID % 1024]);
}
