``` mermaid
---
title: Proyecto DevOps
---
gitGraph
   commit id: "first commit" 
   branch feature/add-feature-1
   commit id: "add-script"
   checkout main
   branch feature/add-feature-2
   commit id: "add-document"
   checkout feature/add-feature-1
   commit id: "add-correction"
   checkout main
   merge feature/add-feature-1
   checkout feature/add-feature-2
   checkout main
   merge feature/add-feature-2 tag: "v1.0.0"
   
```