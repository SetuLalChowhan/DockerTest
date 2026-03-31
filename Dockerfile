# Step 1: Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
# এখানে ডকার নিজেই npm install করবে
RUN npm install
COPY . .
RUN npm run build

# Step 2: Nginx stage (ফাইনাল ইমেজ ছোট রাখার জন্য)
FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]