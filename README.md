# GhidraPlug


<p align="center">

  <img src="images/logo.png" width="400">

</p>

<div align="center">

**Docker scripts for easily building Ghidra and Ghidra plugins for current Ghidra version.**

</div>

## Pre-Reqs

- Docker installed

## Instructions

Clone this repo:

```
git clone https://github.com/lr-m/ghidra-plug
cd ghidra-plug
```

Run the following to create the docker image (with all dependencies), download & build Ghidra (will probably take a while):

```
scripts/create_docker
scripts/run ./scripts/build_ghidra.sh
```

## Plugins

Once the docker is finished and Ghidra is built, you will have something like `/ghidra-plug/out/ghidra_11.3_DEV` (as well as the associated `.zip`)

Add a directory for your plugin in the `/ghidra-plug/plugins` directory. The contents should look something like the included sample:

```
bin    build.gradle            data  extension.properties  README.md
build  certification.manifest  dist  Module.manifest       src
```

Now once this is set up, you can return to `workdir` and run `scripts/build_plugin *plugin name*`, and the plugin should build. For the sample example:

```
scripts/build_plugin sample
```

The result that can be installed into Ghidra will be located in `/ghidra-plug/plugins/*plugin name*/dist` - congrats you built your first plugin!

## Sample

I have included a simplified sample from the Ghidra Github, when built and installed it will add a `HelloWorld` component:

![sample.png](/images/sample.png)

## Credz

This repo was inspired by [ghidra-builder](https://github.com/dukebarman/ghidra-builder), credit to them!


