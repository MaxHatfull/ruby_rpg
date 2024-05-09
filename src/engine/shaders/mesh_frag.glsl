#version 330 core

in vec2 TexCoord;
in vec3 Normal;
in vec3 FragPos;

out vec4 color;

uniform sampler2D image;
uniform vec3 cameraPos;

struct PointLight {
    vec3 position;

    float sqrRange;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};
#define NR_POINT_LIGHTS 16
uniform PointLight pointLights[NR_POINT_LIGHTS];

vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir)
{
    vec3 lightOffset = light.position - fragPos;
    float sqrDistance = dot(lightOffset, lightOffset);
    vec3 lightDir = normalize(lightOffset);
    float diff = max(dot(normal, lightDir), 0.0);

    vec3 reflectDir = reflect(lightDir, normal);
    float spec = pow(max(dot(-viewDir, reflectDir), 0.0), 15);

    float attenuation = light.sqrRange / sqrDistance;

    vec3 ambient = light.ambient;
    vec3 diffuse = light.diffuse  * diff;
    vec3 specular = light.specular * spec;

    ambient *= attenuation;
    diffuse *= attenuation;
    specular *= attenuation;

    return (ambient + diffuse + specular);
}

void main()
{
    vec3 norm = normalize(Normal);
    vec3 viewDir = normalize(cameraPos - FragPos);

    vec3 result = vec3(0.0);

    for (int i = 0; i < NR_POINT_LIGHTS; i++) {
        if (pointLights[i].sqrRange == 0.0)
        {
            break;
        }
        result += CalcPointLight(pointLights[i], norm, FragPos, viewDir);
    }
    vec4 tex = texture(image, TexCoord);
    color = tex * vec4(result, 1.0);
}
