# Mira 📷✨ | EN

**Mira** is a Flutter image-exploration app inspired by Instagram.  
Browse a live gallery, like photos, log in, switch themes, and toggle list- or grid-style layouts.  
Built as a clean, responsive showcase with a strong focus on user experience.

## 🔥 Key features

- 🔍 Displays photos from the Unsplash API
- 🔑 **Email / password authentication (Supabase)**
- ♻️ **Session persistence** – reopen the app and you’re still logged in
- ❤️ Like / unlike system (state handled with Provider)
- 🌗 Light & Dark modes (Theme Switcher)
- 🖼️ List-feed **or** 3-column grid view—switchable on the fly
- 🔁 Infinite scroll with a “Load more” button
- 🧭 Smooth navigation using GoRouter (deep-link ready)
- 🔍 Detail screen for every photo
- 🧱 Clean architecture (services, providers, reusable widgets)

## 🧪 Tech & main packages

| Tech / Package | Purpose |
|----------------|---------|
| **Flutter 3+** | Cross-platform framework |
| `provider` | Global / local state management |
| `go_router` | Declarative routing & deep links |
| `dio` | REST calls (Unsplash + Supabase Auth endpoints) |
| `cached_network_image` | Fast image loading & caching |
| `shared_preferences` | Persist user session locally |

## 📸 Screenshots
*(light / grid / dark examples – update if you grab new shots)*

| Home – List | Home – Grid | Dark Mode |
|-------------|------------|-----------|
| ![list](screenshots/list_view.png) | ![grid](screenshots/grid_view.png) | ![dark](screenshots/dark_mode.png) |

## 🚀 Getting started

```bash
flutter pub get
flutter run
```

---

## 🤝 About the project
Mira was built solo in under 48 hours during an accelerated learning sprint—aiming for clean code, modern UI, and a smooth multi-device experience.

👤 Developed by **@RayanKuhn**  
📫 See GitHub profile for professional contact


# Mira 📷✨ | FR

**Mira** est une application Flutter d’exploration d’images inspirée d’Instagram.  
Galerie dynamique, likes, connexion e-mail, changement de thème (dark / light) et bascule liste / grille : tout est là. Le projet se veut propre, responsive et axé UX.

## 🔥 Fonctions principales

- 🔍 Affichage d’images via l’API Unsplash
- 🔑 **Authentification e-mail / mot de passe (Supabase)**
- ♻️ **Persistance de session** – l’utilisateur reste connecté après redémarrage
- ❤️ Système de likes (Provider)
- 🌙 Mode clair / sombre (ThemeSwitcher)
- 📱 Affichage en liste ou en grille type Instagram
- 🔁 Scroll infini avec bouton « Charger plus »
- 🧭 Navigation fluide (GoRouter)
- 🖼️ Écran de détails pour chaque image
- ⚙️ Architecture propre (services, providers, widgets réutilisables)

## 🧪 Techs & packages utilisés

| Tech / Package | Rôle |
|----------------|------|
| **Flutter 3+** | Framework multiplateforme |
| `provider` | Gestion d’état |
| `go_router` | Routage déclaratif |
| `dio` | Appels REST (Unsplash + Supabase) |
| `cached_network_image` | Cache et chargement d’images |
| `shared_preferences` | Stockage local du token de session |

## 📸 Aperçus

| Accueil (Liste) | Accueil (Grille) | Mode sombre |
|-----------------|------------------|-------------|
| ![list](screenshots/list_view.png) | ![grid](screenshots/grid_view.png) | ![dark](screenshots/dark_mode.png) |

## 🚀 Lancer le projet

```bash
flutter pub get
flutter run
```

## 🤝 À propos

Projet réalisé en solo en moins de 48 h dans un contexte pédagogique accéléré, avec une forte exigence de qualité de code et de design moderne.

👤 Développé par **@RayanKuhn**  
📫 Contact pro disponible sur le profil GitHub


