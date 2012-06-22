process.env.repos or= __dirname + '/repos'

git = require 'git-emit'
pushover = require 'pushover'

sites = {}
repos = pushover process.env.repos

repos.on 'push', (repo) ->
  console.log 'received a push to ' + repo

repos.listen(process.env.port or= 3000)