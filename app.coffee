process.env.repos or= __dirname + '/repos'

connect = require 'connect'
git = require 'git-emit'
pushover = require 'pushover'

repos = pushover process.env.repos

repos.on 'push', (repo) ->
  console.log 'received a push to ' + repo

createRepo = (repo, callback) ->
  repos.exists repo, (exists) ->
    if exists then callback() else repos.create(repo, callback)

emitters = {}

emitter = (repo, callback) ->
  createRepo repo, ->
    console.log 'createRepo ' + repo
    # emitters[repo] or= git(process.env.repos + '/' + repo + '/.git')
    callback()

app = connect()
  .use(connect.logger('dev'))
  .use (req, res, next) ->
    req.repo = req.url.split('/')[1]
    console.log req.repo
    # emitter req.repo, ->
    #   repos.handle(req, res, next)
    repos.handle(req, res, next)

app.listen(process.env.port or= 3000)