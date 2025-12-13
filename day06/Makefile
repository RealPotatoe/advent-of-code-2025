FILE ?= sample.txt

run:
	@kotlinc main.kt -include-runtime -d day06.jar
	@java -jar day06.jar < $(FILE)

clean:
	@rm -f day06.jar