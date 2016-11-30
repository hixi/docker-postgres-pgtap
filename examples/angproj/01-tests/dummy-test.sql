\set ECHO
\set QUIET 1
-- Turn off echo and keep things quiet.

-- Format the output for nice TAP.
\pset format unaligned
\pset tuples_only true
\pset pager

-- Revert all changes on failure.
\set ON_ERROR_ROLLBACK 1
\set ON_ERROR_STOP true

-- Start transaction and plan the tests.
BEGIN;
SELECT plan(2);

SELECT schemas_are(ARRAY['public'], 'only public schema should exist');

SELECT tables_are(
    ARRAY[
      'abteilung', 'angestellter', 'abtleitung', 'projekt', 'projektzuteilung'
    ],
    'angproj should contain all these tables, and none more'
);

-- Finish the tests and clean up.
SELECT * FROM finish();
ROLLBACK;
