# Étape 1 : Construction
FROM node:18 AS build
WORKDIR /app

# Copier UNIQUEMENT les fichiers nécessaires pour npm install
COPY frontend/package.json frontend/package-lock.json ./

# Installer les dépendances
RUN npm install

# Copier TOUT le reste du frontend (public/, src/, etc.)
COPY . .

# Build React
RUN npm run build

# Étape 2 : Déploiement
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
