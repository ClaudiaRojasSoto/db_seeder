# Contributing to DbSeeder

## Git Workflow

This project follows a Git Flow workflow to ensure code quality and stability.

### Branch Structure

- **`main`**: Production-ready code. Protected branch.
- **`develop`**: Integration branch for features. All development happens here.
- **`feature/*`**: Feature branches created from `develop`
- **`hotfix/*`**: Emergency fixes created from `main`

### Development Workflow

1. **Create a feature branch from develop**
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Write tests
   - Implement feature
   - Update documentation

3. **Run tests**
   ```bash
   bundle exec rspec
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: description of your feature"
   ```

5. **Push to GitHub**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to GitHub
   - Create PR from `feature/your-feature-name` to `develop`
   - Wait for review and approval
   - Merge to `develop`

7. **Release to main**
   - When `develop` is stable and ready for release
   - Create PR from `develop` to `main`
   - After approval, merge to `main`
   - Tag the release

### Commit Message Convention

Use clear, descriptive commit messages:

- `Add: new feature or functionality`
- `Fix: bug fix`
- `Update: changes to existing functionality`
- `Refactor: code refactoring`
- `Docs: documentation changes`
- `Test: test additions or modifications`

### Branch Protection Rules (Recommended on GitHub)

#### For `main` branch:
- ✅ Require pull request reviews before merging
- ✅ Require status checks to pass (CI/tests)
- ✅ Require branches to be up to date before merging
- ✅ Require conversation resolution before merging
- ✅ Do not allow bypassing the above settings
- ❌ Disable force pushes
- ❌ Disable deletions

#### For `develop` branch:
- ✅ Require pull request reviews before merging (at least 1)
- ✅ Require status checks to pass
- ❌ Disable force pushes
- ❌ Disable deletions

### Setting Up Branch Protection on GitHub

1. Go to your repository on GitHub
2. Click **Settings** > **Branches**
3. Click **Add rule** under "Branch protection rules"
4. For Branch name pattern, enter: `main`
5. Enable the following:
   - ☑ Require a pull request before merging
   - ☑ Require approvals (1)
   - ☑ Dismiss stale pull request approvals when new commits are pushed
   - ☑ Require status checks to pass before merging
   - ☑ Require branches to be up to date before merging
   - ☑ Require conversation resolution before merging
   - ☑ Do not allow bypassing the above settings
6. Click **Create**
7. Repeat for `develop` branch

### Code Review Guidelines

When reviewing PRs:
- ✅ Check that tests are passing
- ✅ Verify code follows Ruby style guides
- ✅ Ensure documentation is updated
- ✅ Test the changes locally if needed
- ✅ Provide constructive feedback

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/generator_spec.rb

# Run with coverage
bundle exec rspec --format documentation
```

### Release Process

1. Ensure `develop` branch is stable and tested
2. Create PR from `develop` to `main`
3. Update `CHANGELOG.md` with new version
4. Update `lib/db_seeder/version.rb` with new version
5. After merging to `main`, create a git tag:
   ```bash
   git checkout main
   git pull origin main
   git tag -a v0.2.0 -m "Release version 0.2.0"
   git push origin v0.2.0
   ```
6. Build and publish gem:
   ```bash
   gem build db_seeder.gemspec
   gem push db_seeder-0.2.0.gem
   ```

## Questions?

Feel free to open an issue if you have questions about the contribution process.

