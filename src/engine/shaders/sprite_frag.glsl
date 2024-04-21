#version 330 core
in vec2 TexCoords;
out vec4 color;

uniform sampler2D image;
uniform vec3 spriteColor;
uniform vec4 frameCoords;

void main()
{
    vec2 interpolatedCoords = vec2(frameCoords.x + (TexCoords.x * frameCoords.z), frameCoords.y + TexCoords.y * frameCoords.w);;

    color = vec4(spriteColor, 1.0) * texture(image, interpolatedCoords);
}