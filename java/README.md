# Bundled Java libraries

This package bundles pre-built jars under `inst/java/lib` (installed as
`inst/java/lib`) rather than compiling Java sources as part of the build.
Corresponding source for each bundled jar is available upstream:

| Jar                   | Version | Upstream source                                    |
|-----------------------|---------|-----------------------------------------------------|
| TauP-3.1.0.jar        | 3.1.0   | https://github.com/crotwell/TauP                     |
| seisFile-2.3.1.jar    | 2.3.1   | https://github.com/crotwell/seisFile                 |
| seedCodec-1.2.0.jar   | 1.2.0   | https://github.com/crotwell/seedCodec                |
| reload4j-1.2.22.jar   | 1.2.22  | https://reload4j.qos.ch/                              |
| gson-2.13.1.jar       | 2.13.1  | https://github.com/google/gson                        |

License and copyright details for each are in `inst/NOTICE`, with full
license text in `inst/licenses/`.
