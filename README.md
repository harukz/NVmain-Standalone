# NVMain Standalone


Minimal, reproducible standalone NVMain trace simulation on modern Linux using Docker.

This repository is a standalone-focused fork of [SEAL-UCSB/NVmain](https://github.com/SEAL-UCSB/NVmain).

I originally used NVMain for my own research and ended up making a few small fixes and setup improvements along the way. I'm keeping this fork here in case it helps someone else too :)

This fork keeps NVMain's existing standalone trace simulator easy to build and run on current systems.

## Quick start with Docker

Build the image:

```sh
docker build -t nvmain-standalone .
```

Run the bundled sample configuration and trace:

```sh
docker run --rm nvmain-standalone \
  Config/STTRAM_Everspin_4GB.config \
  examples/sample.nvt
```

The same sample is used by default, so this shorter smoke test is equivalent:

```sh
docker run --rm nvmain-standalone
```

The executable accepts an optional cycle limit followed by configuration overrides:

```sh
docker run --rm nvmain-standalone \
  Config/STTRAM_Everspin_4GB.config \
  examples/sample.nvt \
  100000 \
  IgnoreData=true
```

To use files from the host, mount their directory and pass container paths:

```sh
docker run --rm \
  --mount type=bind,src="$PWD",dst=/work,readonly \
  nvmain-standalone \
  /work/example.config \
  /work/example.nvt
```

## Native build

Docker is the reproducible path. For a native build, install a C++ compiler, Python 3, and a current SCons release, then run:

```sh
scons --build-type=fast
./nvmain.fast \
  Config/STTRAM_Everspin_4GB.config \
  examples/sample.nvt
```

Available build types are `fast`, `debug`, and `prof`.

## Command line

```text
nvmain CONFIG_FILE TRACE_FILE [CYCLES [PARAM=value ...]]
```

`CYCLES` defaults to `0`, which processes the entire trace. Later `PARAM=value` arguments override values from the configuration file.

## License

NVMain is distributed under the BSD 2-Clause License. See [LICENSE](LICENSE).