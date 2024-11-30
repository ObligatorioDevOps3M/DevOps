``` mermaid
---
title: Trunk-Based para proyectos de DevOps
---
sequenceDiagram
    box gray Construcción Infraestructura (una vez)
        participant PC
        participant AWS
        participant DevOps (repo)
    end
    PC->>AWS: terraform apply
    AWS->>PC: url de recursos
    PC ->> PC: guardar archivos config
    PC ->> DevOps (repo): commit archivos config

    box blue Despliegue (en cada merge)
        participant App (repo)
        participant ECR
        participant EKS
    end

    DevOps (repo) ->>    App (repo): lee archivos config
    App (repo) ->> ECR: sube imágen container
    App (repo) ->> EKS: despliega imágen
    ECR -->> EKS: pull imágen
```
