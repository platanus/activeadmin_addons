The install generator will automatically do these two changes to your files depending on the configuration used in ActiveAdmin:

## Webpacker or similar

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
