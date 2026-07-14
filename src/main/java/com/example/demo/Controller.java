package com.example.demo;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/v1/demo/")
public class Controller {
    @GetMapping("get-demo-3")
    public ResponseEntity<DemoModel> getTest() {
        DemoModel demoModel = new DemoModel();
        demoModel.setMessage("Hallo, from demo3");
        log.info("get-demo3 - Data: {}", demoModel);
        return ResponseEntity.ok(demoModel);
    }
}
