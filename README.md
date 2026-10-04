# 💬 WhatsApp Contacts Backend API (C++ DevOps Pipeline)

Un projet End-to-End DevOps illustrant le cycle complet de développement, conteneurisation, gestion d'infrastructure et déploiement continu d'une API REST C++ gérant une liste de contacts style WhatsApp.

---

## 🏗️ Architecture du Projet

```text
[ Git Commit/Push ]
       │
       ▼
[ GitHub Actions ] (CI/CD Pipeline)
       │
       ├──► 1. Build & Test (C++ Compiler)
       ├──► 2. Build Docker Image (Multi-Stage Build)
       ├──► 3. Push Image ──► [ GCP Artifact Registry ]
       └──► 4. Terraform Apply ──► [ GCP Cloud Run ] (Production)
