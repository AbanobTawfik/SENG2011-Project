Project Vampire
===============


## Project Setup

Hi, hopefully this guide can help you to get started on the project.
If you have any questions or doubt, do not hesitate to ask anyone!


### Build Requirements

- Some variant of Linux with recent `mono` available.
  I use OpenSUSE Tumbleweed.
- Latest version of `mono` installed. `mono-core` should be
  sufficient.
- Dafny 1.9.7 installed as `dafny1.9.7`.
  - Alternatively, set `DAFNY` environment variable to the
    dafny executable.
  - The `Makefile` will check your `dafny` version and
    complain if the version is not correct.


If you are using Microsoft Windows, then figuring out
how to build this project is left as an exercise to the reader!

Because C# originates from Windows, this should be trivial (hopefully).
See `Makefile` for the commands you need to run.


### Build Steps

We use `Makefile` to specify our build, because it is simple.
No need to deal with projects and crap.

```bash
make
```

Use the following steps to run and clean up.

```bash
mono Main.exe
make clean
```


## Contribution

Here are some thoughts for programming as a team.

- Do not hesitate to contribute! If you are lost at any time,
  you must speak up.
- Speak now if you want a change in project direction.
  We don't have much time to let it linger.
- Do not break verification. Let's try to keep the master branch
  clean and workable. Use a separate branch for your own work.
  Trying to fix your verification problems will be pain for everyone.
- Keep things simple.
