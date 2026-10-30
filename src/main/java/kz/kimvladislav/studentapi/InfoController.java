package kz.kimvladislav.studentapi;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class InfoController {

    @Value("${app.student-name}")
    private String studentName;

    @Value("${app.version}")
    private String version;

    @GetMapping("/")
    public Map<String, String> info() {
        return Map.of(
                "application", "kim-vladislav-student-api",
                "author", studentName,
                "version", version);
    }
}
