import globals from 'globals';
import js from '@eslint/js';
import tseslint from 'typescript-eslint';
import visualComplexity from 'eslint-plugin-visual-complexity';

export default [
  {
    ignores: [
      'dist',
      '*.config.{js, mjs, ts, mts}',
      '**/.features-gen/**',
      '**/test-reports/**',
      '**/cucumber-report/**',
      '**/playwright-report/**',
    ],
  },
  js.configs.recommended,
  ... tseslint.configs.recommendedTypeChecked,
  {
    languageOptions: {
      parserOptions: {
        projectService: {
          allowDefaultProject: ['*.mjs'],
        },
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
  {
    languageOptions: {
      globals: globals.node,
    },
  },
  {
    // all files
    files: ['**/*.{js,mjs,ts}'],
    plugins: {
      visual: visualComplexity,
    },
    rules: {
      complexity: 0,
      'no-console': 'error',
      'no-undef': 0,
      'no-empty-pattern': 0,
      '@typescript-eslint/no-unused-vars': [
        'error',
        { argsIgnorePattern: '^_', destructuredArrayIgnorePattern: '^_' },
      ],
      '@typescript-eslint/no-floating-promises': "error",
      '@typescript-eslint/no-require-imports': 0,
      'visual/complexity': ['error', { max: 5 }],
      'max-depth': ['error', { max: 2 }],
      'max-nested-callbacks': ['error', { max: 2 }],
      'max-params': ['error', { max: 5 }],
      'max-statements': ['error', { max: 12 }, { ignoreTopLevelFunctions: false }],
      'max-lines-per-function': ['error', { max: 35, skipBlankLines: true, skipComments: true }],
      'max-len': ['error', { code: 120, ignoreUrls: true }],
      'max-lines': ['error', { max: 300, skipComments: true, skipBlankLines: true }],

      '@typescript-eslint/triple-slash-reference': 0,
      // require is needed for some functions (copied from PW)
      '@typescript-eslint/no-var-requires': 0,
      '@typescript-eslint/no-empty-function': 0,
    },
  },
];