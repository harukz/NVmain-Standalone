FROM debian:bookworm-slim AS build

RUN apt-get update \
    && apt-get install -y --no-install-recommends g++ scons \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . .
RUN scons --build-type=fast --jobs="$(nproc)"

FROM debian:bookworm-slim

WORKDIR /opt/nvmain
COPY --from=build /src/nvmain.fast ./nvmain.fast
COPY Config ./Config
COPY examples ./examples
COPY LICENSE ./LICENSE

USER 65532:65532
ENTRYPOINT ["./nvmain.fast"]
CMD ["Config/STTRAM_Everspin_4GB.config", "examples/sample.nvt"]
