package com.resismart.RESISMART.controller;

import com.resismart.RESISMART.dto.chambredto.ChambreDTO;
import com.resismart.RESISMART.models.Admin;
import com.resismart.RESISMART.models.Chambre;
import com.resismart.RESISMART.models.Resident;
import com.resismart.RESISMART.service.ChambreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/chambres")
public class ChambreController {

    @Autowired
    private ChambreService chambreService;

    // Endpoint pour récupérer une chambre par son numéro
    @GetMapping("/number/{number}")
    public Optional<Chambre> getChambreByNumber(@PathVariable Integer number) {
        return chambreService.getChambreByNumber(number);
    }

    // Endpoint pour récupérer toutes les chambres d'un type spécifique
    @GetMapping("/type/{type}")
    public List<Chambre> getChambresByType(@PathVariable String type) {
        return chambreService.getChambresByType(type);
    }

    // Endpoint pour récupérer toutes les chambres disponibles
    @GetMapping("/status/{status}")
    public List<Chambre> getChambresByStatus(@PathVariable String status) {
        return chambreService.getChambresByStatus(status);
    }


    // Endpoint pour récupérer tous les résidents associés à une chambre donnée
    @GetMapping("/residents/{chambreId}")
    public List<Resident> getResidentsByChambre(@PathVariable Integer chambreId) {
        return chambreService.getResidentsByChambre(chambreId);
    }

    // Endpoint pour ajouter ou mettre à jour une chambre
    @PostMapping("/")
    public Chambre saveChambre(@RequestBody Chambre chambre) {
        return chambreService.saveChambre(chambre);
    }



//obtient tous les chambreDTO 
    @GetMapping("/all")
     public List<ChambreDTO> getAllChambres() {
        return chambreService.getAllChambres();
    }


//obtient un chambreDTO par id
    @GetMapping("/{id}")
    public ChambreDTO getChambreById(@PathVariable("id") Integer id) {
        return chambreService.getChambreDetails(id);
    }

     @PostMapping("/add")
    public ResponseEntity<String> addChambre(@RequestBody Chambre chambre) {
        try {
            chambreService.addChambreWithAdmin(chambre);
            return ResponseEntity.ok("Chambre ajoutée avec succès !");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erreur lors de l'ajout de la chambre : " + e.getMessage());
        }
    }



    
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteChambre(@PathVariable Integer id) {
        try {
            chambreService.deleteChambreWithResidentsAndIncidents(id);
            return ResponseEntity.ok("Chambre et résidents associés supprimés avec succès !");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erreur lors de la suppression de la chambre : " + e.getMessage());
        }
    }



   
    
}
