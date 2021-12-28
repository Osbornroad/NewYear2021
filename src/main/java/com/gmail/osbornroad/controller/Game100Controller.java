package com.gmail.osbornroad.controller;


import com.gmail.osbornroad.model.Stage;
import com.gmail.osbornroad.model.Team;
import com.gmail.osbornroad.service.StageService;
import com.gmail.osbornroad.service.TeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;


@Controller
@RequestMapping(value = {"/"})
public class Game100Controller {

    @Autowired
    TeamService teamService;

    @Autowired
    StageService stageService;

    @GetMapping()
    public String showMainPage() {
        return "main";
    }

    @GetMapping("/game100")
    public String showGame100() {
        return "game100";
    }

    @GetMapping("/soundRow")
    public String showSoundRow() {
        return"soundRow";
    }

    @GetMapping("/getTeam")
    @ResponseBody
    public ResponseEntity<Team> getTeam() {
        Team team = teamService.getTeam();
        return ResponseEntity.ok(team);
    }

    @PostMapping("/updateTeam")
    @ResponseBody
    public ResponseEntity<Team> updateTeam(@ModelAttribute(value = "team") Team team) {
        Team updatedTeam = teamService.setTeam(team);
        return ResponseEntity.ok(updatedTeam);
    }

    @GetMapping("/getStage/{stageName}")
    @ResponseBody
    public ResponseEntity<Stage> getStage(@PathVariable("stageName") String stageName) {
        Stage stage = stageService.getStage(stageName);
        return ResponseEntity.ok(stage);
    }

    @GetMapping("/big")
    public String getBigGame(Model model) {
        /*model.addAttribute("bigGame1", stageService.getStage("bigGame1"));
        model.addAttribute("bigGame2", stageService.getStage("bigGame2"));
        model.addAttribute("bigGame3", stageService.getStage("bigGame3"));
        model.addAttribute("bigGame4", stageService.getStage("bigGame4"));
        model.addAttribute("bigGame5", stageService.getStage("bigGame5"));
        model.addAttribute("bigGame6", stageService.getStage("bigGame6"));*/
        return "big";
    }

    @GetMapping("/bigGameStages")
    @ResponseBody
    public ResponseEntity<List<Stage>> getBigGameStages() {
        List<Stage> bigGameStages = stageService.getBigGame();
        return ResponseEntity.ok(bigGameStages);
    }

    /*@PostMapping("/teamNames")
    @ResponseBody
    public ResponseEntity<Map<String, String>> getTeamNames(
            @RequestParam(value = "leftTeam") String leftTeam,
            @RequestParam(value = "rightTeam") String rightTeam
    ) {
        fixedLeftTeam = leftTeam;
        fixedRightTeam = rightTeam;
        teamNames.put("fixedLeftTeam", fixedLeftTeam);
        teamNames.put("fixedRightTeam", fixedRightTeam);
        return ResponseEntity.ok(teamNames);
    }*/


 }
