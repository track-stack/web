<img src="https://circleci.com/gh/track-stack/web.png?circle-token=:circle-token" />

# Track Stack

http://track-stack.herokuapp.com

### Assets

If asset compilation is failing on deploy, the problem is most likely the `webpacker:compile` task.

```bash
$ NODE_ENV=production bundle exec rails webpacker:compile
```
