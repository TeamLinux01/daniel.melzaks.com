+++
title = 'It finally makes sense'
date = 2024-07-17T11:47:00-04:00
draft = false
+++

I finally did something that I have been wanting to accomplish for at least five years.

I now have it where I can automatically create PDFs based on asciidoc files in a git repo, without having to have any software installed on any of my machines to do it. I have found both a docker image and a github action to run the docker container which allows me to compile the PDFs, then upload those PDFs as a github artifact that I can download by clicking on the finished action.

I have been managing my resume in a private github repo for a few years now and I really liked asciidoc, so I wrote it using that markup language. Putting the resume in a git repo has been very handy, as I can easily see any changes I have made over the years if I need to go back for whatever reason. I also like that I don't have to worry about losing the files or misplacing a version. It's all stored in one place that I can clone from and push back to.

My issue was that I want to be able to send PDFs instead of the plain markup files. I would have to process the conversion locally and would store a copy inside the repo next to the `.adoc` files. I wasn't a fan of doing that. Installing asciidoctor on the machine is not great and remembering the docker commands to do the processing was equally annoying to me. I could have created an extra document about the docker commands inside the repo, but for some reason I didn't think about that until now.

Now that I have started to learn Github actions, I found what I needed to do to get my idea working. So I found that I needed a few things.

1. Docker image that could process asciidoc.
2. Github action to run docker images.
3. Github action to upload files.
 
For the docker image, I found that [asciidoctor](https://hub.docker.com/r/asciidoctor/docker-asciidoctor) would do the trick. Next was the Github action for running docker images, which I found [addnab/docker-run-action](https://github.com/marketplace/actions/docker-run-action) over on Github. Finally, the upload action is found at [actions/upload-artifact](https://github.com/marketplace/actions/upload-a-build-artifact).

With all that, I created `.github/workflows/Compile PDFs.yml` in my main branch.

```
name: Output PDFs

on:
  push:

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      -
        name: Checkout
        uses: actions/checkout@v4
      -
        name: Run AsciiDoctor container to output PDFs
        uses: addnab/docker-run-action@v3
        with:
          registry: docker.io
          image: asciidoctor/docker-asciidoctor:latest
          options: -v ${{ github.workspace }}:/documents
          run: |
            asciidoctor-pdf *.adoc
      -
        name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: PDFs
          path: ./*.pdf
```

I am very happy with results so far and will continue to refine as I go. So glad to share this with you all. Take care and God Bless.