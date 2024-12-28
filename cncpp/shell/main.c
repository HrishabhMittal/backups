#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#define MAX_INPUT_SIZE 1024
#define MAX_ARGS 64
void execute_command(char *input) {
    char *args[MAX_ARGS];
    char *token = strtok(input, " \t\n");
    int arg_count = 0;
    while (token != NULL && arg_count < MAX_ARGS - 1) {
        args[arg_count++] = token;
        token = strtok(NULL, " \t\n");
    }
    args[arg_count] = NULL;  
    if (args[0] == NULL) {
        return;  
    }
    if (strcmp(args[0], "exit") == 0) {
        exit(0);
    }
    if (strcmp(args[0], "cd") == 0) {
        if (args[1] == NULL) {
            chdir(getenv("HOME"));
        } else if (chdir(args[1]) != 0) perror("cd");
        return;
    }
    pid_t pid = fork();
    if (pid == 0) {
        if (execvp(args[0], args) == -1) {
            perror("Error executing command");
        }
        exit(EXIT_FAILURE);  
    } else if (pid > 0) {
        wait(NULL);  
    } else {
        perror("Fork failed");
    }
}
int main() {
    char input[MAX_INPUT_SIZE];
    while (1) {
        printf("$ ");
        fflush(stdout);
        if (fgets(input, MAX_INPUT_SIZE, stdin) == NULL) {
            break;
        }
        execute_command(input);
    }
    return 0;
}
