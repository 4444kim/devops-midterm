package kz.kimvladislav.studentapi.student;

import java.time.Instant;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class StudentExceptionHandler {

    @ExceptionHandler(StudentNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public Map<String, Object> handleNotFound(StudentNotFoundException ex) {
        return Map.of(
                "status", 404,
                "error", "Not Found",
                "message", ex.getMessage(),
                "timestamp", Instant.now().toString());
    }
}
