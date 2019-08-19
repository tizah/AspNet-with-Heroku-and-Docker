FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["AspNet-with-Heroku-and-Docker/AspNet-with-Heroku-and-Docker/AspNet-with-Heroku-and-Docker.csproj", "AspNet-with-Heroku-and-Docker/AspNet-with-Heroku-and-Docker/"]
RUN dotnet restore "AspNet-with-Heroku-and-Docker/AspNet-with-Heroku-and-Docker/AspNet-with-Heroku-and-Docker.csproj"
COPY . .
WORKDIR "/src/AspNet-with-Heroku-and-Docker/AspNet-with-Heroku-and-Docker"
RUN dotnet build "AspNet-with-Heroku-and-Docker/AspNet-with-Heroku-and-Docker.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "AspNet-with-Heroku-and-Docker/AspNet-with-Heroku-and-Docker.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "AspNet-with-Heroku-and-Docker/AspNet-with-Heroku-and-Docker.dll"]

