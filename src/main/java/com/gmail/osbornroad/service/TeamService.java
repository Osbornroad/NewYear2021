package com.gmail.osbornroad.service;

import com.gmail.osbornroad.model.Team;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TeamService {

    private Team team;

    {
        team = new Team("Команда слева", 0, "Команда справа", 0);
    }

    public Team getTeam() {
        return team;
    }

    public Team setTeam(Team incomingTeam) {
        team = incomingTeam;
        return team;
    }


}
