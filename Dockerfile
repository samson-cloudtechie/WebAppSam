# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# STAGE01 - Build application and its dependencies  
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env  
WORKDIR /app  
COPY SamWebApp/*.csproj ./  
COPY . ./  
RUN dotnet restore   
  
# STAGE02 - Publish the application  
FROM build-env AS publish  
RUN dotnet publish -c Release -o /app  
  
# STAGE03 - Create the final image  
FROM mcr.microsoft.com/dotnet/aspnet:8.0  
WORKDIR /app  
LABEL Author="SamsonD"  
LABEL Maintainer="quickdevnotes"  
COPY --from=publish /app .  
ENTRYPOINT ["dotnet", "WebApp.dll", "--server.urls", "http://*:80"] 