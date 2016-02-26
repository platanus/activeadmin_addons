The install generator will automatically do these two changes to your files:

1. The following line will be added as the **first** line of `app/assets/stylesheets/active_admin.css.scss`:

```stylesheet
//= require activeadmin_addons/all
```

2. The following line will be added on `app/assets/javascripts/active_admin.js.coffee` **after** `#= require active_admin/base`

```javascript
#= require activeadmin_addons/all
```

To undo, you can use

```bash
$ rails d activeadmin_addons:install
```