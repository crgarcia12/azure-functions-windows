# azure-functions-windows

In here you can see how to build Azure functions on windows containers.

## Where do I run my function?
We will use the docker image built by the functions team:
https://github.com/Azure/azure-functions-docker

Today, the latest (and only) Windows Server image is `3.0-nanoserver-1809`


## Where do I build my function?

Since we are using a windows img built by the Functions team, we need to find a Docker image with the correct version of the dotnet SDK (3.x) that is compatible with the previous image.

For that, I am using `mcr.microsoft.com/dotnet/sdk:3.1`

## What do I need to change to my dockerfile
First you need to change the images used in `FROM`

Second you need to create a folder in the windows container, that will be used to store the function

Third you need to use that folder everywhere (Search for approot in bellow code)

```
mkdir -p c:\approot &&`
...
dotnet publish azure-functions-windows.csproj --output C:\approot
...
ENV AzureWebJobsScriptRoot=C:\\approot AzureFunctionsJobHost__Logging__Console__IsEnabled=true
COPY --from=installer-env ["C:\\approot", "C:\\approot"]
```

Here we are using approot because if you go to the dockerfile provided by the Azure Team, you will see that folder as the application root folder 