#version 330 core
layout (location = 0) in vec3 aPos;

uniform vec3 colour;
out vec4 ourColour;

void main()
{
    gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);
    ourColour = vec4(colour, 1.0);
}