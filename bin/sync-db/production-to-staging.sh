#/bin/sh

echo 'This script will overwrite the STAGING database with the contents of the PRODUCTION database.'
echo
read -p 'Do you want to continue? (y/N) ' -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  heroku pg:backups:capture --app ncce-curriculum-production
  echo 'Copying production database to staging database'
  heroku pg:copy ncce-curriculum-production::DATABASE_URL ncce-curriculum-staging::DATABASE_URL --app ncce-curriculum-staging --confirm ncce-curriculum-staging --verbose
  echo 'Database sync complete'
else
  echo 'Database sync cancelled'
fi
