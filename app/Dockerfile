# Stage 1: Build stage
FROM alpine:latest AS builder

# Mettre à jour les dépôts et installer les outils de compilation
RUN apk add --no-cache build-base cmake git

WORKDIR /app
COPY . .

# Compilation de l'exécutable C++
RUN g++ -O3 main.cpp -o whatsapp_backend -lpthread

# Stage 2: Runtime stage
FROM alpine:latest
RUN apk add --no-cache libstdc++

WORKDIR /app
COPY --from=builder /app/whatsapp_backend .

EXPOSE 8080
CMD ["./whatsapp_backend"]
