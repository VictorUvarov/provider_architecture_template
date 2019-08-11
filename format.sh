#!/bin/sh
echo "#!/bin/sh\nexec flutter format lib/ test/" >> .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit