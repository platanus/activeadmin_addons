# Contributing

## Rules

1. **Test everything you add or fix**. Functionality that is not tested is a headache to the future.
1. **Document everything you add**, even an small option. If the functionality is hidden in the code, it is not useful.
In general, we add a brief in the `README.md` and we extend the information in a file inside `/docs`.
1. **Avoid making Pull Requests with multiple changes**. If you intend to add/fix several things, please make a PR for each one.
1. **Ask before attempting to add new features**. In Platanus, we open the code of this gem to spread the happiness but we don't want to maintain things that are not useful for the company. Remember that you can always fork this gem and modify it according to your needs.
1. **Respect the style rules**. We use [rubocop](https://github.com/bbatsov/rubocop), [stylelint](https://github.com/stylelint/stylelint) and [eslint](https://eslint.org/). Te rules are in the root of this gem.

## Dummy App

The gem is a [Rails engine](http://guides.rubyonrails.org/v4.2/engines.html). So you have a dummy app for testing.
To run the application quickly, you can execute in the root of the gem the following command:

```
# To use sprockets
bin/setup

# To use webpacker
bin/setup --use_webpacker
```

This command loads the dummy app with test data.

The command leaves some automatically generated files from the setup process, these files should be (manually) ignored if you want to commit a change. If you want to clean these files you can run `bin/clean` but be warned that it will remove any non-committed change from the `spec/dummy` folder.

To navigate the application you can run, inside the `/spec/dummy` directory:

```
rails s
```

> It is a good idea to add to the dummy app any new functionality. See for example the file: `/spec/dummy/app/admin/invoices.rb`

## Testing

The gem is tested using [rspec](https://github.com/rspec/rspec-rails), [capybara](https://github.com/teamcapybara/capybara#using-capybara-with-rspec) and [selenium-webdriver](https://github.com/SeleniumHQ/selenium/tree/master/rb) with chrome. So, **you need to have chromedriver installed**.
If you're using homebrew on OS X you can do: `brew install chromedriver`.

To run the tests you can do, in the root of the gem,

```
# For running the full setup (sprockets and webpacker)
bundle exec rake tests

# For running in the current environment
bundle exec rspec
```

- The addons specs we put them inside `/spec/features`.
- The helper classes specs we put them inside `/spec/lib`.

## Style rules

We use [Hound](https://houndci.com/) to check the style rules against pull requests. So, you don't need to install the code analyzers or linters if you don't want. But, don't make commits named "style fix" when the hound attacks you, or do it but use [`git rebase`](https://help.github.com/articles/about-git-rebase/).
