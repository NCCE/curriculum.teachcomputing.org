# Curriculum

Testing changes to Heroku/GH integration.

## Development

### Dependencies:

- [Homebrew](https://brew.sh/)
- Docker (incl. Docker Compose, which already part of Docker for Mac and Docker Toolbox) > v4.0 (with support for `docker compose`)
- [asdf](https://asdf-vm.com/guide/getting-started.html#_3-install-asdf)

### Setup

Build the docker image, set up environment variables, and add a nicer local hostname (curriculum.teachcomputing.rpfdev.com):

```
sh scripts/setup.sh
```

Optionally set a password for postgres by updating the value for `DEV_PASS` in your `.env` file.

### Starting and stopping the stack

Start the stack:

```
docker compose up (-d to detach from shell, see the next section for viewing the logs)
```

NOTE: The first run can take some time as `bundle install` will be run for the first time, tailing the logs with `docker compose logs -f` is recommended.

The app is then available at: http://curriculum.teachcomputing.rpfdev.com

Stop the stack:

```
docker compose down
```

### View logs

View logs (add -f to tail, and/or append a container name such as 'curriculum' to tail only that container):

```
docker compose logs
```

For example

```
docker compose -f logs curriculum
```

### Database

The database is automatically setup the first time the container is run, and a migration is performed on each subsequent run.

#### Reset the database

```
yarn run reset-db
```

#### Run migrations

To perform migrations manually (without restarting the container) run:

```
yarn run exec rails db:migrate
```

#### Seeding the database

To seed manually run:

```
docker compose run --rm --no-deps curriculum rails db:seed
```

### Install new Dependencies / Updates

The bundle has now been moved to a separate volume and once the initial build has taken place the bundle directory is mapped to a volume and persisted.

To install/update a new gem, first update the Gemfile and run `docker-compose run curriculum bundle install` or `docker-compose run curriculum bundle update`, then:

```
docker compose run --rm --no-deps curriculum bundle install
```

To reinstall all packages:

```
docker compose build (--no-cache to force it build from scratch)
```

## Testing

Uses [rspec](https://github.com/rspec/rspec)

```
yarn test
```

To use [guard](https://github.com/guard/guard) to watch the tests:

```
yarn run exec guard
```

## Tooling

### ERB Lint

Used for linting ERB / HTML files

Run with `bundle exec erblint --lint-all`

https://github.com/Shopify/erb-lint

### Reek

Used for detecting 'code smell' in your app.

Run with `bundle exec reek`

### Brakeman

Used for static code analysis to check for potential security flaws.

https://brakemanscanner.org/docs/quickstart/

We are ignoring some of the warnings using the method described in the [Brakeman docs](https://brakemanscanner.org/docs/ignoring_false_positives/) We are using the default location for the ignore file, etc.

Run `brakeman -i config/brakeman.ignore .` in the project root and follow the onscreen prompts, outlined in the above doc, to use the tool and check the output for warnings, etc.

### ERD generation

`erd.pdf` will be [generated automatically whenever new migrations are run](https://github.com/voormedia/rails-erd#auto-generation).

To generate `erd.pdf` manually:

```
docker-compose run curriculum bundle exec erd
```

### Debugging

`ruby-debug-ide` is enabled and waiting for connections by default on port `1235`. There is a `launch.json` in the repo and if you're using vscode it should be as easy as going to the 'Run' view, selecting 'Debug Attach' and clicking the green Run button. It's important to note that if you attempt to restart or stop the debug process, this will effectively kill the container, and a `docker compose up -d` will be necessary to continue - however this is rarely necessary in general use since you'll be debugging individual requests.

If you prefer to use `byebug` you'll _first_ need to attach to the container which can be done with the command: `docker attach curriculumteachcomputingorg_curriculum_1` (the container name can be checked with `docker compose ps`, but mostly it'll be the one here), then add your breakpoint and trigger your request. Again ending the session by quitting byebug or hitting `ctrl+c` will kill the container, so you'll need to run `docker compose up -d` again.

### Troubleshooting

> I can access the site at `localhost:3020` but not at `curriculum.teachcomputing.rpfdev.com`

In some circumstances the nginx instance used by dev-nginx may go down, just run `dev-nginx restart-nginx` to bring it up again.

### Syncing Prod DB to Staging

- You must have access to the Heroku apps for staging and production.

To copy the production database into the staging database run:

```
./bin/sync-db/production-to-staging.sh
```
