``` mermaid
---
title: Proyecto DevOps
---
gitGraph
   commit id: "first commit" 
   branch feature/feature-1
   commit id: "add-script"
   checkout main
   branch feature/feature-2
   commit id: "add-document"
   checkout feature/feature-1
   commit id: "add-correction"
   checkout main
   merge feature/feature-1
   checkout feature/feature-2
   checkout main
   merge feature/feature-2 tag: "v1.0.0"

   
```