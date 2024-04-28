#version 330 core

in vec2 TexCoord;
in vec3 Normal;
in vec3 FragPos;

out vec4 color;

uniform sampler2D image;

void main()
{
    float ambientStrength = 0.5;
    vec3 ambient = ambientStrength * vec3(1.0, 1.0, 1.0);

    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(vec3(0.0, -1.0, -1.0));
    vec3 viewPos = vec3(1920 / 2, 1080 / 2, 0.0);
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 12);
    vec3 specular = 5 * spec * vec3(1.0, 1.0, 1.0);

    vec3 diffuse = 0.6 * max(dot(norm, -lightDir), 0.0) * vec3(1.0, 1.0, 1.0);

    vec4 tex = texture(image, TexCoord);

    color = tex * vec4(ambient + diffuse + specular, 1.0);
}