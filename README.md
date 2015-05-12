## Docker Ruby Image

Our custom docker base image for ruby apps.


### Using this image in your app

In your Dockerfile:

```
FROM quay.io/mikamai/ruby:master
...
```

### Building and Pushing

Builds are triggered automatically on push. They updates the `latest` tag and the `<BRANCH>` tag (e.g. a push on the master branch updates the `latest` and `master` tags).

You can also build/push manually. This way a `<COMMIT>` tag is also generated.

```
bundle
rake docker:build docker:push
```
