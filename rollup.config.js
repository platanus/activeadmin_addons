import resolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';
import babel from 'rollup-plugin-babel';
import { uglify } from 'rollup-plugin-uglify';
import { stripIndent } from 'common-tags';

const uglifyOptions = {
  mangle: false,
  compress: false,
  output: {
    beautify: true,
    indent_level: 2,
    preamble: stripIndent`
      /* eslint-disable */
      /**
       * Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/activeadmin_addons/' and run \`yarn build\`
       */
      //= require select2.full
      //= require jquery.xdan.datetimepicker.full
    ` + '\n'
  },
};

export default {
  input: 'app/javascript/activeadmin_addons/all.js',
  output: {
    file: 'app/assets/javascripts/activeadmin_addons/all.js',
    format: 'umd',
    name: 'ActiveAdmin Addons',
  },
  plugins: [
    resolve(),
    commonjs(),
    babel(),
    uglify(uglifyOptions),
  ],
  // Use client's yarn dependencies instead of bundling everything
  external: [
    'jquery-datetimepicker',
    'select2',
  ],
};
