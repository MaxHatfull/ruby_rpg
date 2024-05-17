#version 330 core

in vec2 TexCoord;
in vec3 Normal;
in vec3 FragPos;

out vec4 color;

uniform sampler2D image;
uniform vec3 cameraPos;

struct DirectionalLight {
    vec3 direction;

    vec3 diffuse;
    vec3 specular;
};
#define NR_DIRECTIONAL_LIGHTS 4
uniform DirectionalLight directionalLights[NR_DIRECTIONAL_LIGHTS];

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

vec3 CalcDirectionalLight(DirectionalLight light, vec3 normal, vec3 fragPos, vec3 viewDir)
{
    float diff = max(dot(normal, -light.direction), 0.0);

    vec3 reflectDir = reflect(-light.direction, normal);
    float spec = pow(max(dot(-viewDir, reflectDir), 0.0), 15);

    vec3 diffuse = light.diffuse  * diff;
    vec3 specular = light.specular * spec;

    return (diffuse + specular);
}

void main()
{
    vec3 norm = normalize(Normal);
    vec3 viewDir = normalize(cameraPos - FragPos);

    vec3 result = vec3(0.1);

    for (int i = 0; i < NR_POINT_LIGHTS; i++) {
        if (pointLights[i].sqrRange == 0.0)
        {
            break;
        }
        result += CalcPointLight(pointLights[i], norm, FragPos, viewDir);
    }

    for (int i = 0; i < NR_DIRECTIONAL_LIGHTS; i++) {
        if (directionalLights[i].diffuse + directionalLights[i].specular == vec3(0.0))
        {
            break;
        }
        result += CalcDirectionalLight(directionalLights[i], norm, FragPos, viewDir);
    }

    vec4 tex = texture(image, TexCoord);
    color = tex * vec4(result, 1.0);
}
