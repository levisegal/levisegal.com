+++
date = "2017-04-10T18:43:02-06:00"
title = "second post"

+++

Install Chokidar

Why?

Node.js fs.watch:

* Doesn't report filenames on OS X.
* Doesn't report events at all when using editors like Sublime on OS X.
* Often reports events twice.
* Emits most changes as rename.
* Has a lot of other issues
* Does not provide an easy way to recursively watch file trees.


Make build.js



