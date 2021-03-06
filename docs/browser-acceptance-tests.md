# Browser/Acceptance Tests

## Quick start:

To run browser tests, open a new Terminal window or tab and change to the project directory,
then tell gulp to start the tests:

```sh
gulp build
gulp test:acceptance ( tox -e acceptance can be run as well )
```

There are several options you can pass to run a particular suite of tests,
to run a particular list of features,
and/or to run it in "fast" mode:

```sh
gulp test:acceptance --suite=wagtail-admin ( runs just the wagtail-admin suite )
gulp test:acceptance --specs=multiselect.feature ( runs just the multiselect feature )
gulp test:acceptance --tags=@mobile ( runs all scenarios tagged with @mobile )
gulp test:acceptance --recreate ( runs the tests and recreates the virtual environment )
```

The same options can be used with tox (--omitted):

```sh
tox -e acceptance suite=wagtail-admin
tox -e acceptance specs=multiselect.feature
tox -e acceptance tags=@mobile
```

These tests will run on their own server; you do not need to be running your development server.

## Cucumber - tool for running automated tests written in plain language

Below are some suggested standards for Cucumber Feature files:

*Table copied from https://saucelabs.com/blog/write-great-cucumber-tests by Greg Sypolt, with moderate modifications*
<table>
   <tbody>
      <tr>
         <td>Feature Files</td>
         <td>Every *.feature file consists in a single feature, focused on the business value.</td>
      </tr>
      <tr>
      <td><a href="https://github.com/cucumber/cucumber/wiki/Gherkin">Gherkin</a></td>
         <td>
            <pre>Feature:Title (one line describing the story)
Narrative Description: As a [role], I want [feature], so that I [benefit]<br>
Scenario: Title (acceptance criteria of user story)
  Given [context]
  And [some more context]...
  When [event]
  Then [outcome]
  And [another outcome]...<br>
Scenario:...
</pre>
</td>
      </tr>
      <tr>
         <td>Given, When, and Then Statements</td>
         <td>
           There might be some confusion surrounding where to put the verification step in the Given, When, Then sequence. Each statement has a purpose. <br><br>

  - **Given** is the pre-condition to put the system into a known state before the user starts interacting with the application
  - **When** describes the key action the user performs
  - **Then** is observing the expected outcome

  Just remember the <em>‘then’</em> step is an acceptance criteria of the story.
   </td>
      </tr>
      <tr>
         <td><a href="https://github.com/cucumber/cucumber/wiki/Background">Background</a></td>
         <td>The background needs to be used wisely. If you use the same steps at the beginning of all scenarios of a feature, put them into the feature’s background scenario. The background steps are run before each scenario.
<pre>
Background:
  Given I am logged into Wagtail as an admin
  And I create a Wagtail Sublanding Page
  And I open the content menu</pre>
        </td>
      </tr>
      <tr>
         <td>Scenarios</td>
         <td>Keep each scenario independent. The scenarios should run independently, without any dependencies on other scenarios.  Scenarios should be between 3 to 6 statements, if possible.</td>
      </tr>
      <tr>
         <td><a href="https://github.com/cucumber/cucumber/wiki/Scenario-Outlines">Scenario Outline</a></td>
         <td>If you identify the need to use a scenario outline, take a step back and ask the following question: Is it necessary to repeat this scenario ‘x’ amount of times just to exercise the different combination of data? In most cases, one time is enough for UI level testing.</td>
      </tr>
      <tr>
         <td>Declarative Vs Imperative Scenarios</td>
         <td>
            The declarative style describes behavior at a higher level, which improves the readability of the feature by abstracting out the implementation details of the application.  The imperative style is more verbose but better describes the expected behavior.  Either style is acceptable.<br><br>
<u>Example: Declarative</u>
<pre>
Scenario:User logs in
  Given I am on the homepage
  When I log in
  Then I should see a login notification
</pre>
<u>Example: Imperative</u>
<pre>
Scenario: User logs in
  Given I am on the homepage
  When I click on the "Login" button
  And I fill in the "Email" field with "me@example.com"
  And I fill in the "Password" field with "secret"
  And I click on "Submit"
  Then I should see "Welcome to the app, John Doe"
</pre>
         </td>
      </tr>
   </tbody>
</table>


## Sauce Connect - send tests to the cloud

Sauce Labs can be used to run tests remotely in the cloud.

1. Log into [https://saucelabs.com/account](https://saucelabs.com/account).

2. Update and uncomment the `SAUCE_USERNAME`, `SAUCE_ACCESS_KEY`,
   and `SAUCE_SELENIUM_URL` values in your `.env` file.
   The access key can be found on the Sauce Labs
   [user settings page](https://saucelabs.com/beta/user-settings).

3. Reload the settings with `source .env`.

4. Run the tests with `gulp test:acceptance --sauce`.

5. Monitor progress of the tests
   on the [Sauce Labs dashboard](https://saucelabs.com/dashboard) Automated Tests tab.

!!! Note
    If you get the error `Error: ENOTFOUND getaddrinfo ENOTFOUND`
    while running a test, it likely means that Sauce Connect is not running.

## Manual test configuration

A number of command-line arguments can be set to test particular configurations:

 - `--suite`: Choose a particular suite or suites to run.
   For example, `gulp test:acceptance --suite=content` or `gulp test:acceptance --suite=content,functional`.
 - `--specs`: Choose a particular spec or specs to run.
   For example, `gulp test:acceptance --specs=header.feature`, `gulp test:acceptance --specs=header.feature,pagination.feature`, or `gulp test:acceptance --specs=filterable*.feature`. If `--suite` is specified, this argument will be ignored. If neither `--suite` nor `--specs` are specified, all specs will be run.
 - `--windowSize`: Set the window size in pixels in `w,h` format.
   For example, `gulp test:acceptance --windowSize=900,400`.
 - `--browserName`: Set the browser to run.
   For example, `gulp test:acceptance --browserName=firefox`.
 - `--version`: Set the browser version to run.
   For example, `gulp test:acceptance --version='44.0'`.
 - `--platform`: Set the OS platform to run.
   For example, `gulp test:acceptance --platform='osx 10.10'`.
 - `--sauce`: Whether to run on Sauce Labs or not.
   For example, `gulp test:acceptance --sauce=false`.


## Tests

Tests are organized into suites under the `test/browser_tests/cucumber/features` directory. Any new tests should be added to an existing suite (e.g. "default"), or placed into a new suite directory. All tests start with writing a `.feature` spec in one of these suites, and then adding corresponding step definitions, found in `test/browser_tests/cucumber/step_definitions`.

## Further reading

- [Cucumber features](https://github.com/cucumber/cucumber/wiki/Feature-Introduction)
- [Protractor](https://angular.github.io/protractor/#/)
- [Select elements on a page](https://www.seleniumhq.org/docs/03_webdriver.jsp#locating-ui-elements-webelements)
- [Writing Jasmin expectations](https://jasmine.github.io/2.0/introduction.html#section-Expectations).
- [Understanding Page Objects](https://www.thoughtworks.com/insights/blog/using-page-objects-overcome-protractors-shortcomings)




## Performance testing

To audit if the site complies with performance best practices and guidelines,
run `gulp audit:perf`.

The audit will run against
[Google's Lighthouse](https://github.com/GoogleChrome/lighthouse).




## Accessibility Testing

Run the acceptance tests with an `--a11y` flag (i.e. `gulp test:acceptance --a11y`)
to check every webpage for WCAG and Section 508 compliancy using Protractor's
[accessibility plugin](https://github.com/angular/protractor-accessibility-plugin).

If you'd like to audit a specific page, use `gulp audit:a11y`:

  1. Enable the environment variable `ACHECKER_ID` in your `.env` file.
     Get a free [AChecker API ID](https://achecker.ca/register.php) for the value.
  2. Reload your `.env` with `source ./.env` while in the project root directory.
  3. Run `gulp audit:a11y` to run an audit on the homepage.
  4. To test a page aside from the homepage, add the `--u=<path_to_test>` flag.
     For example, `gulp audit:a11y --u=contact-us`
     or `gulp audit:a11y --u=the-bureau/bureau-structure/`.




## Source code linting

The default test task includes linting of the JavaScript source, build,
and test files.
Use the `gulp lint` command from the command-line to run the ESLint linter,
which checks the JavaScript against the rules configured in `.eslintrc`.
[See the ESLint docs](https://eslint.org/docs/rules/)
for detailed rule descriptions.

There are a number of options to the command:

 - `gulp lint:build`: Lint only the gulp build scripts.
 - `gulp lint:test`: Lint only the test scripts.
 - `gulp lint:scripts`: Lint only the project source scripts.
 - `--fix`: Add this flag (like `gulp lint --fix` or `gulp lint:build --fix`)
   to auto-fix some errors, where ESLint has support to do so.
