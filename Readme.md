![rust logo][logo]

# Docker/Rust

![dockeri.co][dockericon]


## Summary

This docker image provides **Rust** compiler environment on debian.


## Base Image

This docker images are built on **debian:jessie-20180831** .


## Environment

Running a container created with this image without extra arguments,
bash shell is executed with the user named *rust*.
And this user is belong to *sudoers*, so you have permissions to be able to execute any operations in containers.

- user id is `rust` and uid is `1000`
- group id is `rust` and gid is `1000`
- *$HOME* is set to `/home/rust`
- *$PWD* is `/home/rust/source` (default working directory)

NOTICE:
  `DEBIAN_FRONTEND=noninteractive` is set by default.
  Then you run a container from this image interactively, confirmation messages are may be suppressed by default.


## Example

Default working directory is an empty directory owned by the user rust.
So, it is suggested that mounting a directory contains your rust project as `/home/rust/source`, building it with `cargo build`:

```sh
$ docker run -it --rm -v `pwd`:/home/rust/source eldesh/rust:latest cargo build
```


## Tags

This docker image series are tagged corresponds to the official rust toolchain naming rule.

- latest(nightly)
- stable
- 1.30.0
- 1.29.2
- 1.29.1
- 1.29.0
- 1.25.0


## Links

- [Rust](https://www.rust-lang.org/en-US/ "Rust")

[logo]: https://www.rust-lang.org/logos/rust-logo-blk.svg "a system programming language"
[dockericon]: https://dockeri.co/image/eldesh/rust "dockeri.co"
