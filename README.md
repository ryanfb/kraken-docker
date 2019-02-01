kraken-docker
=============

Docker container for the [kraken OCR engine](https://github.com/mittagessen/kraken).

## Usage

Basically, replace `kraken` in every call with `docker run --rm -it ryanfb/kraken`, e.g.

`kraken --help` -> `docker run -it ryanfb/kraken --help`

You can also override the `kraken` `ENTRYPOINT` with the `--entrypoint` argument, e.g. to drop into an interactive `bash` shell with the current host directory mapped to the container's `/data` volume:

    docker run -it --entrypoint "/bin/bash" -v $(pwd):/data ryanfb/kraken

## Shared Memory

If you're trying to train networks with this image, you may run into an error like:

    ERROR: Unexpected bus error encountered in worker. This might be caused by insufficient shared memory (shm).

This is because Docker defaults to 64MB of SHM no matter how much memory its allocated. You can override this by passing e.g. `--shm-size=256M` as an argument to `docker run` before the Docker image name.

## CUDA

There's also a CUDA variant defined in `Dockerfile.cuda` that uses the NVIDIA CUDA baseimage and installs a CUDA-enabled pytorch. It's on the `cuda` tag, and you should be able to run it with [`nvidia-docker`](https://github.com/NVIDIA/nvidia-docker):

    nvidia-docker run -it ryanfb/kraken:cuda --help
