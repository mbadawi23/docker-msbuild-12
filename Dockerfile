FROM microsoft/dotnet-framework:4.7

SHELL ["powershell"]

# TODO: Define temp folder location
#ENV TEMP /temp/
#ENV TEMPW "\\temp\\"


# Add bin directory to image
ADD temp/ /temp

# Istall MSBuild 12. & Nuget, then remove temp dir
RUN & "C:\temp\BuildTools_Full.exe /Silent /Full | out-null"; 
RUN & "Test-Path 'C:\Program Files (x86)\MSBuild\12.0\bin'";
RUN \ 
 & "cp \temp\nuget.exe C:\Windows\nuget.exe"; \
 & "rm \temp -r -force"; 

#ENV NUGET \\Windows\\nuget.exe

# Set work dir for MSBuild
#WORKDIR "C:\Program Files (x86)\MSBuild\12.0\Bin"

# Add Msbuild to path
RUN setx PATH '%PATH%;C:\\Program Files (x86)\\MSBuild\\12.0\\Bin\\msbuild.exe'

# Run MSBuild, this is where to specify a project to build
CMD ["C:\\Program Files (x86)\\MSBuild\\12.0\\Bin\\msbuild.exe"]
