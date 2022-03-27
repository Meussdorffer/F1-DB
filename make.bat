@REM Delete old.
del *.zip

@REM Build layer.
@REM docker run --rm --volume=$(pwd):/lambda-build -w=/lambda-build lambci/lambda:build-python3.7 pip install -r requirements.txt --target python
@REM docker run --rm --volume="%cd%":/lambda-build -w=/lambda-build lambci/lambda:build-python3.7 pip install -r requirements.txt --target pyenv/python


@REM Build function.
tar -acf lambda.zip -C python *
tar -acf layer.zip -C pyenv python