## Create our backend jar
gradle bootJar

## Create the build directory structure
mkdir -p ./build/dependency && (cd ./build/dependency; jar -xf ../libs/*.jar)