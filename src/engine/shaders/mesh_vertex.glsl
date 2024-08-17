#version 330 core

// <vec2 position, vec2 texCoords, vec3 normal, vec3 tangent>
layout (location = 0) in vec3 vertex;
layout (location = 1) in vec2 texCoord;
layout (location = 2) in vec3 normal;
layout (location = 3) in vec3 tangent;
layout (location = 4) in vec3 diffuse;
layout (location = 5) in vec3 specular;
layout (location = 6) in vec3 albedo;

out vec2 TexCoord;
out vec3 Normal;
out vec3 Tangent;
out vec3 FragPos;
out vec3 Diffuse;
out vec3 Specular;
out vec3 Albedo;

uniform mat4 camera;
uniform mat4 model;

void main()
{
    TexCoord = texCoord;
    mat3 normalMatrix = mat3(transpose(inverse(model)));
    Normal = normalMatrix * normal;
    Tangent = normalMatrix * tangent;
    FragPos = vec3(model * vec4(vertex, 1.0));
    gl_Position = camera * model * vec4(vertex, 1.0);
    Diffuse = diffuse;
    Specular = specular;
    Albedo = albedo;
}
