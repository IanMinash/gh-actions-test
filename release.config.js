module.exports = {
  branches: ['main','Edward_Release'],
  repositoryUrl: 'https://github.com/WUonam04/gh-actions-test',
  plugins: [
    '@semantic-release/commit-analyzer',
    '@semantic-release/release-notes-generator',
    '@semantic-release/changelog',
    '@semantic-release/npm',
    [
      '@semantic-release/github',
      {
        assets: [
          'dist/**',
          'python/main.py'
        ],
        message: 'chore(release): ${nextRelease.version} [skip ci]'
      }
    ],
    '@semantic-release/git'
  ],
  preset: 'conventionalcommits',
  tagFormat: 'v${version}'
};
