kraken-docker
=============

Docker container for the [kraken OCR engine](https://github.com/mittagessen/kraken).

## Usage

Basically, replace `kraken` in every call with `docker run --rm -it ryanfb/kraken kraken`, e.g.

`kraken --help` -> `docker run -it ryanfb/kraken kraken --help`

Or to drop into an interactive `bash` shell with the current host directory mapped to the container's `/data` volume:

    docker run -it -v $(pwd):/data ryanfb/kraken /bin/bash

## Kraken Models

This container no longer ships with any Kraken models pre-downloaded. There's a persistent Docker volume set up at `/models`, so you can do e.g.:

    docker run -it -v models:/models ryanfb/kraken kraken get default

And downloaded models will persist across runs when you use that volume:

    docker run -it -v models:/models ryanfb/kraken ls /models

## Shared Memory

If you're trying to train networks with this image, you may run into an error like:

    ERROR: Unexpected bus error encountered in worker. This might be caused by insufficient shared memory (shm).

This is because Docker defaults to 64MB of SHM no matter how much memory it's allocated. You can override this by passing e.g. `--shm-size=256M` as an argument to `docker run` before the Docker image name.

## CUDA

There's also a CUDA variant defined in `Dockerfile.cuda` that uses the NVIDIA CUDA baseimage and installs a CUDA-enabled pytorch. It's on the `cuda` tag, and you should be able to run it with [`nvidia-docker`](https://github.com/NVIDIA/nvidia-docker):

    nvidia-docker run -it ryanfb/kraken:cuda kraken --help
