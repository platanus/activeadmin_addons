The install generator will automatically do these two changes to your files:

1. The following line will be added as the **first** line of `app/assets/stylesheets/active_admin.scss`:

```stylesheet
//= require activeadmin_addons/all
```

2. If your activeadmin installation uses an `app/assets/javascripts/active_admin.js.coffee` file,
   the following line will be added **after** `#= require active_admin/base`:

```coffeescript
#= require activeadmin_addons/all
```

2. If your activeadmin installation uses an `app/assets/javascripts/active_admin.js` file,
   the following line will be added **after** `//= require active_admin/base`:

```javascript
//= require activeadmin_addons/all
```

To undo, you can use

```bash
$ rails d activeadmin_addons:install
```

3. An initializer will be added. From there, you can change the Addons' default config.
