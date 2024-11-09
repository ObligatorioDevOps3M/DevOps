``` mermaid
---
title: Proyecto Código
---
gitGraph

   commit id: "first commit" 
   branch develop
   checkout develop
   commit id: "backport" 
   branch feature/feature1
   checkout feature/feature1
   commit id: "add code1" 
   checkout develop
   branch feature/feature2
   checkout feature/feature2
   commit id: "add code2" 
   commit id: "add tests2" 
   checkout feature/feature2
   checkout develop 
   merge feature/feature2
   checkout feature/feature1
   commit id: "add tests1" 
   checkout develop 
   merge feature/feature1
   checkout main
   merge develop tag: "v1.0.0"
   checkout main
   branch hotfix/fix-1
   commit id: "fix prod"
   checkout hotfix/fix-1
   checkout main
   merge hotfix/fix-1 tag: "v1.0.1"
   checkout develop
   merge main tag: "v1.0.1 backport"
   ``` 