# eq-questionnaire-schemas

A repo for building questionnaire schemas for eq-questionnaire-runner.

A number of make targets exist in order to create/test schemas locally:

| Build Command |       |
| ------- |-------|
| build | Build schemas using jsonnet and translate them |
| build-schemas | Build schemas in english using jsonnet |
| test-schemas | Test schemas using eq-schema-validator docker image |

Build commands are only executed for english versions of schemas, due to changes neccessary to validator in order to accomodate characters from other languages.

| Translation Command |       |
| ------- |-------|
| translate-schemas | Translate english schemas |
| translation-templates | Extracts empty templates for translation (.pot) |
| test-translation-templates | Tests that current translation templates are up to date |


## Testing built census schemas with eq-questionnaire-runner

In order to test the census schemas built in this repo you will need to create a symbolic link between a /schemas directory in runner and the schemas directory that is generated here. 

In eq-questionnaire-schemas:

Use `make build` to generate the census schemas and populate the /schema directory.

In your local eq-questionnaire-runner repository:

Remove the `/schemas` directory if it already exists

Create a symbolic link pointing at your generated census schema files by running the following command:
```
ln -s /eq-questionnaire-schemas/schemas /eq-questionnaire-runner/schemas
```
You should now be able launch a questionnaire using one of the cenus schemas.
