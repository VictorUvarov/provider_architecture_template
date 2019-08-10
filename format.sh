#!/bin/sh
echo "#!/bin/sh\nexec flutter format app/lib/ app/test/" >> ../.git/hooks/pre-commit
chmod +x ../.git/hooks/pre-commit