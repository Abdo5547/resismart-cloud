# Étape 1 : Construction
FROM node:18 AS build
WORKDIR /app

# Copier package.json et package-lock.json
COPY frontend/package.json frontend/package-lock.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du code source (public/, src/, etc.)
COPY public ./public
COPY src ./src

# Construire l'application React
RUN npm run build

# Étape 2 : Déploiement
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
