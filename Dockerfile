# Use the official .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project file(s) to the container
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core runtime image as the base image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Set the working directory in the container
WORKDIR /app

# Copy the published output from the build stage to the final stage
COPY --from=build /app/out .

# Expose the port that the application will run on
EXPOSE 8081

# Define the entry point for the container
ENTRYPOINT ["dotnet", "Jenkins.dll"]