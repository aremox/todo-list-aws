#!/bin/bash
python3.7 -m venv todo-list-aws
source todo-list-aws/bin/activate
#python -m pip install --upgrade pip
#For static testing
#python -m pip install radon
#python -m pip install flake8
#python -m pip install flake8-polyfill
#python -m pip install bandit
#For integration testing
#python -m pip install pytest
#For unit testing
#python -m pip install boto3
#python -m pip install moto
#python -m pip install mock==4.0.2
#python -m pip install coverage==4.5.4
export PYTHONPATH="${PYTHONPATH}:$(pwd)"
echo "PYTHONPATH: $PYTHONPATH"
export DYNAMODB_TABLE=todoUnitTestsTable
#python test/unit/TestToDo.py
#pip show coverage
coverage run --include=src/todoList.py test/unit/TestToDo.py
coverage report
coverage xml
