The install generator will automatically do these two changes to your files depending on the configuration used in ActiveAdmin:

## Sprockets

1. The following line will be added as the **first** line of `app/assets/stylesheets/active_admin.scss`:

```stylesheet
@import 'activeadmin_addons/all'
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

## Webpacker

1. The following line will be added as the **first** line of `app/javascript/stylesheets/active_admin.scss`

```stylesheet
@import 'activeadmin_addons/src/stylesheets/all'
```

2. The following line will be added **after** `import "@activeadmin/activeadmin"` in `app/javascript/packs/active_admin.js`

```javascript
import "activeadmin_addons" 
```

3. `yarn add activeadmin_addons` will be run to add the npm package.

----

To undo, you can use

```bash
$ rails d activeadmin_addons:install
```

3. An initializer will be added. From there, you can change the Addons' default config.
