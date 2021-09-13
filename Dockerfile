# escape=`
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS installer-env

COPY . /src/dotnet-function-app
RUN cd /src/dotnet-function-app &&`
    mkdir -p c:\approot &&`
    dotnet publish azure-functions-windows.csproj --output C:\approot

# To enable ssh & remote debugging on app service change the base image to the one below
# FROM mcr.microsoft.com/azure-functions/dotnet:3.0-appservice
FROM mcr.microsoft.com/azure-functions/dotnet:3.0-nanoserver-1809
ENV AzureWebJobsScriptRoot=C:\\approot AzureFunctionsJobHost__Logging__Console__IsEnabled=true
COPY --from=installer-env ["C:\\approot", "C:\\approot"]

EXPOSE 80
EXPOSE 443


